[![MIT License](https://img.shields.io/badge/Code-MIT-blue.svg)](LICENSE)
[![CC-BY 4.0](https://img.shields.io/badge/Data-CC--BY_4.0-lightgrey.svg)](LICENSE-data)
![Last Updated](https://img.shields.io/badge/updated-2026--07--03-success)

# corpus-guide — machine-fetchable navigation for the open corpus

This repository is the **structured, machine-readable map** of the open Spectral Branding
research corpus — Spectral Brand Theory (SBT), Organizational Schema Theory (OST), and the
meaning/meaningfulness program. It is the data layer behind the human guide at
[spectralbranding.com/guide](https://spectralbranding.com/guide) and the narrative map at
[github.com/spectralbranding](https://github.com/spectralbranding).

Everything here is a **generated projection** of the corpus substrate — do not hand-edit.
Each file is regenerated from source and screened for public safety at emit time.

| File | What it is |
| :--- | :--------- |
| [`corpus-map.json`](./corpus-map.json) | papers ↔ terms ↔ claims navigation graph for **seed → scope** expansion: from a seed of 1–2 papers, widen to every paper bearing on a task via shared terms and corpus-internal citations. Navigation only — claim/method text lives in each paper's `paper.yaml` and the decision router. |
| [`guide-routing.json`](./guide-routing.json) | the **role map** — 12 cohort accelerators (CMO, COO, CFO, researcher, AI agent, …), each with seed papers, instruments, the decisions it can act on, and an `expand_via` neighbourhood. An accelerator, not a gate: every role carries the `other` fallback. |
| [`articles-map.json`](./articles-map.json) | published long-form **article ↔ corpus-paper** edges, derived from trusted signals only (publication date ≤ today + a live canonical URL + in-body DOI references). |

## 1 | Getting Started

Point your agent at `corpus-map.json` + `guide-routing.json`, give it your task, and let it
widen from the seeds before answering — and, like the corpus instruments, tell you what it
**cannot resolve** instead of inventing an answer. See [`AGENTS.md`](./AGENTS.md).

Raw URLs (fetch these directly):

- `https://raw.githubusercontent.com/spectralbranding/corpus-guide/main/corpus-map.json`
- `https://raw.githubusercontent.com/spectralbranding/corpus-guide/main/guide-routing.json`
- `https://raw.githubusercontent.com/spectralbranding/corpus-guide/main/articles-map.json`

Where this fits:

- **Human guide (rendered):** [spectralbranding.com/guide](https://spectralbranding.com/guide)
- **Narrative org map + repositories:** [github.com/spectralbranding](https://github.com/spectralbranding)
- **Decision router (semantic):** [consult.orgschema.com](https://consult.orgschema.com)
- **Measure a brand:** the [Brand Spectrometer](https://meter.spectralbranding.com) — for a
  measurement, route to the instrument, not the papers.

## 2 | Project Layout

```
corpus-guide/
|-- README.md            <- this file
|-- AGENTS.md            <- how to point an AI agent at the map
|-- CITATION.cff         <- machine-readable citation
|-- LICENSE              <- MIT (code: reproduce.sh)
|-- LICENSE-data         <- CC BY 4.0 (JSON data artifacts)
|-- corpus-map.json      <- papers <-> terms <-> claims navigation graph
|-- guide-routing.json   <- 12-role cohort accelerator map
|-- articles-map.json    <- article <-> corpus-paper edges
|-- reproduce.sh         <- artifact validation (see section 3)
`-- output/
    |-- figures/.gitkeep
    |-- tables/.gitkeep
    `-- logs/.gitkeep    <- validation run log lands here
```

## 3 | Quick Start

The seed → scope reading recipe (the map is an **accelerator, not a gate** — seeds are entry
points, not answer sets):

1. Start from your seed paper key(s) in `corpus-map.json` `papers[]`.
2. Read each seed's `terms{owns, imports, refines}`.
3. For each term, look it up in `terms[]` and follow `papers{owns, imports, refines}` to every
   other paper that uses it — those are in scope.
4. Union `citation_edges` where `from`/`to` is a seed (who cites / is cited by it).
5. Ground the answer in the widened set, and **state any paper you could not resolve**.

To validate the shipped artifacts locally:

```bash
./reproduce.sh                  # validate all JSON artifacts, log to output/logs/
./reproduce.sh --check-only     # verify dependencies only
```

Note on regeneration: the three JSON files are **generated projections of the private corpus
substrate** and are regenerated upstream at emit time (with a public-safety screen). They are
not rebuilt from sources inside this repository; `reproduce.sh` validates their integrity
(well-formed JSON, expected top-level structure) rather than regenerating them.

## 4 | Dependencies

- `bash` + `git`
- `jq` **or** Python `>=3.9` (either one is sufficient for JSON validation)

No package installation is required; the data artifacts are plain JSON.

## 5 | Script Map

| Script | Purpose |
|--------|---------|
| `reproduce.sh` | Validate the three JSON artifacts (well-formed, non-empty, expected top-level keys); write run log to `output/logs/validate_run.log` |

There are no generation scripts in this repository by design — generation lives upstream with
the corpus substrate (see section 3).

## 6 | Citation

Machine-readable form: [`CITATION.cff`](./CITATION.cff). GitHub renders a "Cite this
repository" widget from that file.

## 7 | Licence

Dual-licence discipline:

- **Code** (`reproduce.sh`) — MIT, see [`LICENSE`](./LICENSE)
- **Data** (`corpus-map.json`, `guide-routing.json`, `articles-map.json`, docs) — Creative
  Commons Attribution 4.0 International (CC BY 4.0), see [`LICENSE-data`](./LICENSE-data)

---

*Last updated: 2026-07-03*
