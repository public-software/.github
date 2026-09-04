# Writing for Public Software

**The rule.** Write every public document of every repository in Simplified Technical English (ASD-STE100).

This applies to README files, handbooks, the site, contributor guides, RFC text, crate documentation and release notes.
It does not apply to code, commit messages, issue comments or chat.
The standard was made for aircraft maintenance manuals, which many readers use in a second language.
Our readers are the same: people from many countries, and coding agents.

## Get the specification

The specification is free.
Request a copy on [asd-ste100.org](https://www.asd-ste100.org/request.html), and ASD sends the PDF.
It has two parts: the writing rules and a dictionary of approved words.
The dictionary is the copyright of ASD.
Do not copy the dictionary into a repository. Link to this page instead.

## The rules

You can apply these rules without the dictionary. Each rule below is a short form of one or more rules in the standard.

1. Write one topic in one sentence. Write one instruction in one sentence.
2. Keep a sentence to 20 words in a procedure, and to 25 words in a description.
3. Keep a paragraph to one topic and to six sentences.
4. Use the active voice. Say who does what. "The build writes state.json", not "state.json is written".
5. Write an instruction in the imperative. "Run the tests", not "the tests should be run".
6. Use only the simple present, the simple past, the simple future, the infinitive and the imperative.
7. Do not use an -ing form as a noun or as a verb. "The build starts", not "the build is starting".
8. Keep a noun cluster to three words. "The catalog schema file", not "the catalog repository schema validation file".
9. Use one word for one thing, and one meaning for one word. Do not use a synonym for variety.
10. Start a warning or a caution with the command. "Do not push to main. The ruleset rejects the push."
11. Put a sequence of steps in a vertical list, one step per item, in the order of the work.
12. Do not use slang, idioms, contractions or Latin abbreviations. Write "for example", not "e.g.".
13. Define a technical name the first time you use it. Then use that name and no other.
14. Write a number as a figure. Write a unit with its symbol.

## Words

The catalog and the handbook define the names of the suite. Use them and no synonym.

| Use | Do not use |
|---|---|
| repository | repo, project, module (for a repository) |
| crate | package, library (for a crate) |
| component | part, artifact, deliverable |
| ring (spine, platform, system, domain, standards) | tier, level, layer (for a ring) |
| layer (L0 to L18) | level, stratum, band (for a layer) |
| wave | phase, milestone (for a wave) |
| readiness (none, seed, partial, shipped) | maturity, status (for readiness) |
| release train | release, version (for a train) |
| the suite | the platform, the stack, the ecosystem |
| pull request | PR, merge request |
| the catalog | the ledger (the ledger is the picture of the layers) |

## Examples

Before: The site, which is rebuilt nightly from the same data that the profile README is generated from, shows the components each repository has shipped, as declared in its own CATALOG.toml, and derives from them a readiness that is displayed on the landing page as well as on every repository page.

After: The site shows the components each repository has shipped. It reads them from the repository's CATALOG.toml. The build runs every night. The landing page and each repository page show the readiness.

Before: Contributors are expected to have signed off their commits and should ensure that any implementation they may have consulted is appropriately recorded.

After: Sign off every commit. Record every implementation you consulted in PROVENANCE.md.

Before: Utilizing the CLI's checking functionality prior to opening a PR is strongly recommended.

After: Run `pub check` before you open a pull request.

## What we check

A checker for the mechanical rules (sentence length, passive voice, -ing forms) will run in CI.
Until it runs, a reviewer applies the rules by hand.
A document that was written before this rule is rewritten when it is next changed.
