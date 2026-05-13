# `data/` — the workshop dataset

## `plant_growth.csv`

A **simulated** glasshouse growth experiment (no real plants involved — see
`make_plant_growth.R` for exactly how it was generated). It has the structure of
a small repeated-measures plant trial, which makes it a clean example for a
**linear mixed-effects model**.

**Design.** 18 plants — 3 genotypes (`A`, `B`, `C`), 6 plants each — grown in 6
benches/"blocks" of 3 plants, with each plant's **height** measured once a week
for 6 weeks.

| column      | type    | description |
|-------------|---------|-------------|
| `plant_id`  | string  | plant identifier, `P01`…`P18` (the unit measured repeatedly) |
| `genotype`  | factor  | `A`, `B`, or `C` |
| `block`     | factor  | bench/block, `B1`…`B6` (3 plants per block) |
| `week`      | integer | weeks since the start: `0, 1, 2, 3, 4, 5` |
| `height_cm` | numeric | plant height in cm at that week |

108 rows (18 plants × 6 weeks).

**Why this needs a mixed model.** The six measurements on a given plant aren't
independent — plants differ in how tall they start (a *random intercept*) and in
how fast they grow (a *random slope* on `week`). Genotype is a thing we care
about *on average* (a *fixed effect*): do genotypes differ in growth rate? A
sensible model is roughly:

```r
library(lme4)
m <- lmer(height_cm ~ week * genotype + (week | plant_id), data = d)
# (block is in the data too if you want to add (1 | block))
```

**Regenerating it.** From inside this directory: `Rscript make_plant_growth.R`.
The script is deterministic (`set.seed(2026)`) and documents the *true*
data-generating parameters — handy if you want to compare them with what your
fitted model recovers.

> Prefer a different dataset? `lme4::sleepstudy` (reaction time vs. days of sleep
> deprivation, `(Days | Subject)`) is the classic teaching example and works with
> the same exercise — just point the agent at it instead.
