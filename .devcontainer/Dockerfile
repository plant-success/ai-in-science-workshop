# Dev-container image for the AI-in-science workshop:
#   rocker "tidyverse" devcontainer base  +  Quarto CLI  +  the extra R packages
#   the mixed-effects exercise needs — all baked in, so Codespaces launch fast.
#
# Build & push with:  scripts/build-image.sh   (or the GitHub Actions workflow
# in .github/workflows/). After editing this file, re-run that script and the new
# image goes live for everyone.

# rocker-org devcontainer image (R + tidyverse / ggplot2 / dplyr preinstalled).
# Bump this tag deliberately and re-test: https://github.com/rocker-org/devcontainer-images
ARG ROCKER_TAG=4.4
FROM ghcr.io/rocker-org/devcontainer/tidyverse:${ROCKER_TAG}

USER root

# ---------------------------------------------------------------------------
# Quarto CLI
# ---------------------------------------------------------------------------
# Installs the latest stable Quarto by default. To pin, pass
# --build-arg QUARTO_VERSION=1.7.1 (see https://github.com/quarto-dev/quarto-cli/releases).
ARG QUARTO_VERSION=latest
RUN set -eux; \
    if [ "${QUARTO_VERSION}" = "latest" ]; then \
      QUARTO_VERSION="$(curl -fsSL https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest \
        | grep -oP '"tag_name"\s*:\s*"v\K[^"]+')"; \
    fi; \
    echo "Installing Quarto ${QUARTO_VERSION}"; \
    curl -fsSL -o /tmp/quarto.deb \
      "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb"; \
    dpkg -i /tmp/quarto.deb; \
    rm -f /tmp/quarto.deb; \
    quarto --version
# Want PDF output too? add a line:  RUN quarto install tinytex --no-prompt  (bigger image)

# ---------------------------------------------------------------------------
# Extra R packages for the exercise (tidyverse / ggplot2 are already in the base)
# ---------------------------------------------------------------------------
RUN install2.r --error --skipinstalled --ncpus -1 \
      lme4 \
      broom.mixed \
      performance \
      marginaleffects \
      patchwork \
 && rm -rf /tmp/downloaded_packages /tmp/*.rds /var/lib/apt/lists/*

# Smoke test: make sure the key packages load.
RUN R -q -e 'invisible(lapply(c("tidyverse","lme4","broom.mixed","marginaleffects","patchwork","performance"), library, character.only = TRUE)); cat("R packages OK\n")'
