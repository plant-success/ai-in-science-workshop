# ai-in-science-workshop

Hands-on exercise for the **AI use in science** seminar (ARC Centre of Excellence
for Plant Success in Nature and Agriculture).

You'll drive an **AI coding agent** (GitHub Copilot in *agent mode*) inside a real
project — in your browser, nothing to install — to fit a **linear mixed-effects
model** to a small plant-growth dataset, write a **Quarto report** that explains
the model and plots the results, and have the agent **check its own work**.

## Quick start

1. Click **`Use this template`** → **`Create a new repository`** (in your own
   account).
2. On your new repo: **`<> Code`** → **`Codespaces`** → **`Create codespace on
   main`**. Wait for VS Code to open in the browser.
3. Open **Copilot Chat** (`Ctrl/Cmd+Alt+I`), set the mode dropdown to **`Agent`**.
4. Follow **[`PARTICIPANT-GUIDE.md`](PARTICIPANT-GUIDE.md)** — it has the exact
   prompt to paste and what "done" looks like.

## What's in here

| path | what it is |
|------|------------|
| [`PARTICIPANT-GUIDE.md`](PARTICIPANT-GUIDE.md) | step-by-step for participants (start here) |
| [`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json) | the Codespace recipe — points at a prebuilt image, adds the VS Code extensions |
| [`.devcontainer/Dockerfile`](.devcontainer/Dockerfile) | how that image is built: rocker tidyverse base + Quarto + the exercise R packages |
| [`scripts/build-image.sh`](scripts/build-image.sh) | build & push the image to GHCR — re-run after editing the Dockerfile |
| [`.github/workflows/build-devcontainer-image.yml`](.github/workflows/build-devcontainer-image.yml) | same thing, but as a GitHub Action (uses `GITHUB_TOKEN`, no PAT) |
| [`data/`](data/) | the dataset (`plant_growth.csv`), its data dictionary, and the script that generated it |
| [`analysis.qmd`](analysis.qmd) | a starting skeleton for the report (the agent can fill it in, or start fresh) |

## For the organiser

**1. The dev-container image.** Codespaces here pull a prebuilt image
(`ghcr.io/plant-success/ai-in-science-workshop:latest`) so they start fast. Build
it once before the workshop, and re-build whenever you change
`.devcontainer/Dockerfile`:

- locally: `scripts/build-image.sh` (needs Docker + a `write:packages` PAT — see the script header), **or**
- on GitHub: run the **build-devcontainer-image** workflow (Actions tab → Run workflow), **or** just push a change to the Dockerfile and it builds automatically.

After the **first** build, make the package **Public** (and confirm the repo has
access) at `github.com/orgs/Plant-Success/packages`. If you don't have a prebuilt
image yet, you can temporarily set `devcontainer.json` to `"build": { "dockerfile":
"Dockerfile" }` to build on launch (slower).

**2. Repo setup.** Mark this repo a **Template repository** (Settings → General).
A GitHub Codespaces *prebuild* (Settings → Codespaces) is optional once the image
exists — the image already does the heavy lifting — and only speeds up codespaces
created on *this* repo, not on copies made from the template.

**3. Dry run.** Create a codespace → open Copilot Chat in **Agent** mode → paste
the prompt from `PARTICIPANT-GUIDE.md` → let it render `analysis.qmd` → time it.
Full checklist in the seminar project notes (`docs/codespaces-getting-started.md`).
