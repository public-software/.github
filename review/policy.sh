#!/usr/bin/env bash
# suite / policy — the deterministic half of the agent review gate. Reads the agent's verdict plus the pull
# request facts the workflow gathered, adds the two rubric rules a script can decide on its own (trailer,
# provenance), and turns hard findings into a failing check. Prints the review comment on stdout.
#
#   policy.sh <verdict.json> <commits.json> <body.txt> <provenance-added.txt>
#     verdict.json           the agent's structured output {summary, findings[{rule, severity, detail, location}]}; may be empty
#     commits.json           [{sha, message}] of the pull request
#     body.txt               the pull request description
#     provenance-added.txt   the lines the pull request adds to PROVENANCE.md
#   AGENT_RESULT    needs.agent.result: success | failure | cancelled | skipped
#   AGENT_SKIPPED   why the agent did not run: "" | merge_group | draft | fork
#   RUBRIC_URL      where the rubric is published (optional)
#
# Rubric rules: scope, tests, provenance, trailer, secrets, semver, agents — the agent judges all seven;
# trailer and provenance are also decided here, so they block even when the agent could not run.
# Exit 0 passes, 1 blocks. In the merge queue nothing is read: the verdict was enforced on the pull request.
set -euo pipefail

MARKER="<!-- pub-review -->"
COPYLEFT='(^|[^[:alnum:]])(AGPL|LGPL|GPL|SSPL|EUPL)([^[:alnum:]]|$)'
BOILERPLATE='two-team rule|do not author|None consulted'   # the skeleton's own PROVENANCE.md wording

verdict_file="${1:-}"; commits_file="${2:-}"; body_file="${3:-}"; provenance_file="${4:-}"
agent_result="${AGENT_RESULT:-skipped}"; agent_skipped="${AGENT_SKIPPED:-}"; rubric_url="${RUBRIC_URL:-}"

# finding <rule> <severity> <detail> [location] — one JSON finding on stdout
finding() { jq -cn --arg r "$1" --arg s "$2" --arg d "$3" --arg l "${4:-}" '{rule: $r, severity: $s, detail: $d, location: $l}'; }

# trailer_findings — a hard finding per commit without a Signed-off-by trailer
trailer_findings() {
  [[ -s "$commits_file" ]] || return 0
  jq -r '.[] | select(.message | test("(^|\n)Signed-off-by: ") | not) | .sha[0:7]' "$commits_file" \
    | while IFS= read -r sha; do finding trailer hard "commit $sha has no Signed-off-by trailer (git commit -s)"; done
}

# copyleft_lines <file> <label> — a hard finding per line that cites a copyleft licence
copyleft_lines() {
  [[ -s "$1" ]] || return 0
  { grep -E "$COPYLEFT" "$1" || true; } | { grep -vE "$BOILERPLATE" || true; } \
    | while IFS= read -r line; do finding provenance hard "cites a copyleft source: ${line:0:120}" "$2"; done
}
provenance_findings() { copyleft_lines "$provenance_file" "PROVENANCE.md"; copyleft_lines "$body_file" "pull request description"; }

# agent_findings — the agent's own findings, or a hard finding when there is no verdict to trust
agent_findings() {
  case "$agent_skipped" in fork|draft) return 0 ;; esac
  if [[ "$agent_result" != "success" ]]; then
    finding agents hard "the agent review did not complete ($agent_result); re-run the failed job — if its log shows an authentication or entitlement error, the organization policy \"Allow use of Copilot CLI billed to the organization\" is off"
    return 0
  fi
  [[ -s "$verdict_file" ]] || return 0
  jq -c '.findings[]? | {rule, severity, detail, location: (.location // "")}' "$verdict_file"
}

summary() { [[ -s "$verdict_file" ]] && jq -r '.summary // empty' "$verdict_file" || true; }
count() { jq --arg s "$1" '[.[] | select(.severity == $s)] | length' "$2"; }
# bullets <severity> <findings.json> — one markdown bullet per finding of that severity
bullets() {
  jq -r --arg s "$1" '.[] | select(.severity == $s) | "- **\(.rule)** — \(.detail)" + (if .location != "" then " (`\(.location)`)" else "" end)' "$2"
}

# comment <findings.json> — the sticky review comment
comment() {
  local all="$1" hard soft s
  hard="$(count hard "$all")"; soft="$(count soft "$all")"
  printf '%s\n' "$MARKER"
  if (( hard > 0 )); then printf '## Agent review: blocked (%s hard)\n\n' "$hard"; else printf '## Agent review: passed\n\n'; fi
  s="$(summary)"; [[ -n "$s" ]] && printf '%s\n\n' "$s"
  if (( hard > 0 )); then printf '### Hard findings (block the merge)\n\n'; bullets hard "$all"; printf '\n'; fi
  if (( soft > 0 )); then printf '### Soft findings (advisory)\n\n'; bullets soft "$all"; printf '\n'; fi
  case "$agent_skipped" in
    fork) printf '_The agent reviews branches of this repository only: a fork'"'"'s workflow token carries no Copilot permission. A maintainer pushes the branch here for the agent pass; the checks above ran._\n\n' ;;
    draft) printf '_Draft: the agent reviews once the pull request is ready for review; the checks above ran._\n\n' ;;
  esac
  [[ -n "$rubric_url" ]] && printf 'Rubric: %s\n' "$rubric_url"
  return 0
}

if [[ "$agent_skipped" == "merge_group" ]]; then
  printf '%s\n## Agent review: passed\n\nIn the merge queue the verdict recorded on the pull request stands; nothing is re-reviewed here.\n' "$MARKER"
  exit 0
fi
all="$(mktemp)"; trap 'rm -f "$all"' EXIT
{ trailer_findings; provenance_findings; agent_findings; } | jq -s . > "$all"
comment "$all"
[[ "$(count hard "$all")" -eq 0 ]]
