# Simulated glasshouse growth experiment for the AI-in-science workshop.
#
# Run this from inside the data/ directory to (re)generate plant_growth.csv:
#     Rscript make_plant_growth.R
# It is fully deterministic via set.seed(), so re-running gives the same file.
#
# DESIGN
#   - 18 plants: 3 genotypes (A, B, C) x 6 plants each
#   - each plant measured weekly for 6 weeks (week = 0, 1, ..., 5)
#   - plants arranged in 6 benches/"blocks" of 3 plants
#   - plants vary in starting height (random intercept) AND growth rate
#     (random slope on week); genotypes differ in MEAN growth rate;
#     blocks add a small offset; measurement noise on top.
#   => the natural model is something like
#         height_cm ~ week * genotype + (week | plant_id)   [+ (1 | block)]
#
# This is SIMULATED data (no real plants were harmed). The "true" parameters are
# below — useful if you want to compare them with what a fitted model recovers.

set.seed(2026)

genotypes  <- c("A", "B", "C")
n_per_geno <- 6
weeks      <- 0:5

# --- true (data-generating) parameters --------------------------------------
intercept_pop <- 5.0                              # mean starting height (cm)
slope_pop     <- c(A = 2.0, B = 3.0, C = 4.0)     # mean growth (cm / week) by genotype
sd_int        <- 1.2                              # SD of plant starting heights
sd_slope      <- 0.6                              # SD of plant growth rates
sd_block      <- 0.8                              # SD of block offsets
sd_resid      <- 0.7                              # measurement noise SD

# --- build the plant-level table --------------------------------------------
plants <- data.frame(
  plant_id = sprintf("P%02d", seq_len(length(genotypes) * n_per_geno)),
  genotype = rep(genotypes, each = n_per_geno),
  stringsAsFactors = FALSE
)
plants$block    <- paste0("B", rep(seq_len(6), length.out = nrow(plants)))  # 3 plants / block
plants$re_int   <- rnorm(nrow(plants), 0, sd_int)
plants$re_slope <- rnorm(nrow(plants), 0, sd_slope)

block_re <- stats::setNames(
  rnorm(length(unique(plants$block)), 0, sd_block),
  sort(unique(plants$block))
)

# --- expand to plant x week and simulate heights ----------------------------
dat <- expand.grid(plant_id = plants$plant_id, week = weeks,
                   KEEP.OUT.ATTRS = FALSE, stringsAsFactors = FALSE)
dat <- merge(dat, plants, by = "plant_id")
dat$height_cm <- with(dat,
  intercept_pop + re_int + block_re[block] +
    (slope_pop[genotype] + re_slope) * week +
    rnorm(nrow(dat), 0, sd_resid)
)
dat$height_cm <- round(dat$height_cm, 2)

dat <- dat[order(dat$plant_id, dat$week),
           c("plant_id", "genotype", "block", "week", "height_cm")]
rownames(dat) <- NULL

write.csv(dat, "plant_growth.csv", row.names = FALSE)
cat("Wrote", nrow(dat), "rows x", ncol(dat), "cols to plant_growth.csv\n")
