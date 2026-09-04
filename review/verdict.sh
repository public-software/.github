#!/usr/bin/env bash
# review/verdict.sh <answer.txt> <verdict.json> — the agent's answer turned into the verdict policy.sh reads.
#
# The Copilot CLI prints the model's answer as text (-s). The prompt asks for the JSON object alone, but a model
# may fence it or wrap it in a sentence, so the first JSON object found in the answer is taken and checked against
# the schema: summary (a string) and findings (an array of {rule, severity, detail, location?} with rule one of
# the seven rubric rules and severity hard or soft). The verdict is written compact with location always present
# (empty when the agent gave none), which is what policy.sh expects. Exit 1 says what is wrong: a malformed
# answer fails the agent job, and suite / policy then blocks with "no verdict to trust".
set -euo pipefail

RULES='["scope","tests","provenance","trailer","secrets","semver","agents"]'
answer="${1:?usage: verdict.sh <answer.txt> <verdict.json>}"; out="${2:?usage: verdict.sh <answer.txt> <verdict.json>}"

# first_object <file> — the first JSON object in the text, compact, or exit 3
first_object() {
  python3 - "$1" <<'PY'
import json, sys
text = open(sys.argv[1], encoding="utf-8", errors="replace").read()
decoder = json.JSONDecoder()
at = text.find("{")
while at != -1:
    try:
        value, _ = decoder.raw_decode(text, at)
        if isinstance(value, dict):
            print(json.dumps(value, separators=(",", ":")))
            sys.exit(0)
    except ValueError:
        pass
    at = text.find("{", at + 1)
sys.exit(3)
PY
}

object="$(first_object "$answer")" || { echo "verdict: no JSON object in the agent's answer ($answer)" >&2; exit 1; }

if ! jq -e --argjson rules "$RULES" '
    (.summary | type == "string") and (.findings | type == "array")
    and all(.findings[]; (.rule as $r | $rules | index($r) != null)
                         and (.severity == "hard" or .severity == "soft")
                         and (.detail | type == "string"))' <<<"$object" >/dev/null; then
  unknown="$(jq -r --argjson rules "$RULES" '[.findings[]? | .rule | select(. as $r | $rules | index($r) == null)] | unique | join(", ")' <<<"$object" 2>/dev/null || true)"
  echo "verdict: the answer's JSON is not a verdict (summary: string, findings: [{rule, severity: hard|soft, detail}])${unknown:+; unknown rule: $unknown}" >&2
  exit 1
fi

jq -c '{summary, findings: [.findings[] | {rule, severity, detail, location: (.location // "")}]}' <<<"$object" > "$out"
