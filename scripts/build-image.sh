#!/usr/bin/env bash
#
# Build the workshop dev-container image and push it to GitHub Container Registry
# (GHCR). Re-run this whenever you change .devcontainer/Dockerfile (or just want
# fresher package versions baked in).
#
# ── one-time setup ─────────────────────────────────────────────────────────
#  • Docker installed and running.  (A GitHub Codespace also works — it has Docker.)
#  • A GitHub Personal Access Token with the `write:packages` scope (classic PAT),
#    or a fine-grained PAT with "Packages: write" for the Plant-Success org.
#    Then log Docker in to GHCR:
#        echo "$GHCR_PAT" | docker login ghcr.io -u <your-github-username> --password-stdin
#  • You need permission to publish packages in the org (repo admins normally do).
#
# ── after the FIRST push ───────────────────────────────────────────────────
#    Make the package PUBLIC so participants' Codespaces can pull it without auth:
#      github.com/orgs/Plant-Success/packages  →  ai-in-science-workshop
#        →  Package settings  →  Danger Zone  →  Change visibility  →  Public
#    Also check the workshop repo is listed under the package's "Repository access".
#
# ── usage ──────────────────────────────────────────────────────────────────
#    scripts/build-image.sh                    # build :latest (+ a dated tag) and push
#    OWNER=l-a-yates scripts/build-image.sh    # push to a personal namespace instead
#    QUARTO_VERSION=1.7.1 scripts/build-image.sh   # pin Quarto
#    ROCKER_TAG=4.5 scripts/build-image.sh     # bump the rocker base
#    NO_PUSH=1 scripts/build-image.sh          # build locally only, don't push
#
set -euo pipefail

# ── config (override any of these via environment variables) ───────────────
REGISTRY="${REGISTRY:-ghcr.io}"
OWNER="${OWNER:-plant-success}"                 # GHCR namespace — MUST be lowercase
IMAGE="${IMAGE:-ai-in-science-workshop}"
ROCKER_TAG="${ROCKER_TAG:-4.4}"                 # rocker base tag (keep in sync with the Dockerfile default)
QUARTO_VERSION="${QUARTO_VERSION:-latest}"      # or pin, e.g. 1.7.1

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOCKERFILE="${REPO_ROOT}/.devcontainer/Dockerfile"

FQIN="${REGISTRY}/${OWNER}/${IMAGE}"
DATE_TAG="$(date +%Y%m%d-%H%M)"

echo "==> Building ${FQIN}"
echo "    tags:        latest, ${DATE_TAG}"
echo "    rocker base: ${ROCKER_TAG}    quarto: ${QUARTO_VERSION}"
echo

docker build \
  --build-arg "ROCKER_TAG=${ROCKER_TAG}" \
  --build-arg "QUARTO_VERSION=${QUARTO_VERSION}" \
  -f "${DOCKERFILE}" \
  -t "${FQIN}:latest" \
  -t "${FQIN}:${DATE_TAG}" \
  "${REPO_ROOT}"

if [[ "${NO_PUSH:-0}" == "1" ]]; then
  echo
  echo "==> NO_PUSH=1 set — built locally, not pushing."
  echo "    Try it:  docker run --rm -it ${FQIN}:latest R --version"
  exit 0
fi

echo
echo "==> Pushing ${FQIN}:latest and ${FQIN}:${DATE_TAG}"
docker push "${FQIN}:latest"
docker push "${FQIN}:${DATE_TAG}"

cat <<EOF

==> Done.
      ${FQIN}:latest
      ${FQIN}:${DATE_TAG}

If this was the FIRST push, make the package PUBLIC on GitHub (see this script's
header). After that, any Codespace can pull it — including participants' copies
made from the template.
EOF
