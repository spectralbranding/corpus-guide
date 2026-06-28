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

## seed → scope (how to read the map)

The map is an **accelerator, not a gate**. Seeds are entry points, not answer sets.

1. Start from your seed paper key(s) in `corpus-map.json` `papers[]`.
2. Read each seed's `terms{owns, imports, refines}`.
3. For each term, look it up in `terms[]` and follow `papers{owns, imports, refines}` to every
   other paper that uses it — those are in scope.
4. Union `citation_edges` where `from`/`to` is a seed (who cites / is cited by it).
5. Ground the answer in the widened set, and **state any paper you could not resolve**.

## Use it with your own AI

Point your agent at `corpus-map.json` + `guide-routing.json`, give it your task, and let it
widen from the seeds before answering — and, like the corpus instruments, tell you what it
**cannot resolve** instead of inventing an answer. See [`AGENTS.md`](./AGENTS.md).

Raw URLs (fetch these directly):

- `https://raw.githubusercontent.com/spectralbranding/corpus-guide/main/corpus-map.json`
- `https://raw.githubusercontent.com/spectralbranding/corpus-guide/main/guide-routing.json`
- `https://raw.githubusercontent.com/spectralbranding/corpus-guide/main/articles-map.json`

## Where this fits

- **Human guide (rendered):** [spectralbranding.com/guide](https://spectralbranding.com/guide)
- **Narrative org map + repositories:** [github.com/spectralbranding](https://github.com/spectralbranding)
- **Decision router (semantic):** [consult.orgschema.com](https://consult.orgschema.com)
- **Measure a brand:** the [Brand Spectrometer](https://meter.spectralbranding.com) — for a
  measurement, route to the instrument, not the papers.

## License

Data: CC BY 4.0 (see [`LICENSE`](./LICENSE)). Cite via [`CITATION.cff`](./CITATION.cff).
