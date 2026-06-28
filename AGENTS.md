# AGENTS.md — consuming the corpus-guide map

You are reading the machine navigation layer for the open Spectral Branding corpus. Use it as
an **accelerator, not a gate**: seeds are entry points, not answer sets.

## Protocol

1. **Route the task.** `guide-routing.json` maps 12 roles → seed papers, instruments, the
   decisions each can act on, and an `expand_via` neighbourhood. Match the incoming role/task
   text against each role's `aliases` + `jtbd` + `expand_via.terms`. No confident match → use
   the `other` fallback (`fallback.readme_index` + `fallback.semantic_router` +
   `fallback.corpus_map`). Never a dead end.
2. **Widen from the seeds** with `corpus-map.json` (seed → scope):
   - read each seed's `terms{owns, imports, refines}`;
   - for each term, follow `papers{owns, imports, refines}` to every other paper that uses it;
   - union `citation_edges` where `from`/`to` is a seed.
3. **Ground and disclose.** Answer only from the widened set, and **state any paper or term
   you could not resolve** — never invent a claim, citation, or DOI.
4. **Measurement is not a reading.** To obtain cohort-resolved, 8-dimension brand perception
   from real evidence, route to the **Brand Spectrometer**
   ([meter.spectralbranding.com](https://meter.spectralbranding.com)) — the answer is a
   measurement produced by the instrument, not text drawn from the papers.
5. **Per-paper detail.** Structured claims live in each paper folder's `paper.yaml` (Paper
   Spec) + `ONTOLOGY.yaml`; resolve `[@key]` cites against the bundled `<key>.bib`. Start from
   the reading paths in the [org map](https://github.com/spectralbranding).

## Raw map URLs

- `https://raw.githubusercontent.com/spectralbranding/corpus-guide/main/corpus-map.json`
- `https://raw.githubusercontent.com/spectralbranding/corpus-guide/main/guide-routing.json`
- `https://raw.githubusercontent.com/spectralbranding/corpus-guide/main/articles-map.json`
