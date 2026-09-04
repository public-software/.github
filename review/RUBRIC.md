# The review rubric

Every pull request in Public Software is read by an agent against these seven rules before a human
reviews it. The agent reports a finding for each rule the change breaks; it reports nothing for the rules the
change satisfies. A **hard** finding fails the required check `suite / policy`; a **soft** finding is
advice in the review comment. The rules `trailer` and `provenance` are also decided by the check itself,
so they block even when the agent could not run.

| Rule | Severity | The reviewer asks | Self-check before opening the pull request |
|---|---|---|---|
| `scope` | soft, hard when the change does something the issue or RFC never asked for | Does the change do one thing, the thing its issue or RFC describes? An interface change or a change across repositories needs an RFC. | Link the issue. Split unrelated changes. |
| `tests` | hard when a behaviour change ships without a test that fails without it | Is there a test that fails on `main` and passes with the change? Documentation-only and mechanical changes are exempt. | Run the new test against `main` once. |
| `provenance` | hard | Was anything copyleft (GPL, AGPL, LGPL, SSPL, EUPL) consulted, cited or ported? Is every reference that was consulted listed in `PROVENANCE.md`? | Only specifications, conformance suites and permissive references; list them. |
| `trailer` | hard | Does every commit carry a `Signed-off-by:` trailer (Developer Certificate of Origin)? | `git commit -s`; `git rebase --signoff` fixes a branch. |
| `secrets` | hard | Does the diff add a credential, token, private key or a personal address that is not the author's sign-off? | Search the diff for `key`, `token`, `secret`, `BEGIN` before pushing. |
| `semver` | soft, hard when a public interface changes and the description says nothing about it | Does the description state the semver impact of a public API change (breaking, feature, fix)? | One line in the description: "semver: minor (new function ...)". |
| `agents` | soft | Does the change follow the repository's `AGENTS.md` (conventions, forbidden paths, required checks) when there is one? | Read `AGENTS.md`; run `pub check`. |

The agent has no write tools: it reads the diff, the description, `PROVENANCE.md` and `AGENTS.md`, and
returns a verdict. A finding names the rule, the severity, one line of detail and a `file:line` when there
is one. Disagree with a finding in the review thread; a maintainer with bypass can merge over a hard finding
that is wrong, and the rubric is corrected in the bootstrap kit.
