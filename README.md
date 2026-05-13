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
| [`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json) | the Codespace recipe: R + Quarto + Copilot + the exercise packages |
| [`data/`](data/) | the dataset (`plant_growth.csv`), its data dictionary, and the script that generated it |
| [`analysis.qmd`](analysis.qmd) | a starting skeleton for the report (the agent can fill it in, or start fresh) |

## For the organiser

Before the seminar: mark this repo a **Template repository** (Settings → General),
and set up a **Codespaces prebuild** for `main` (Settings → Codespaces) so
launches are fast. Pin the devcontainer image tag and do a full dry run (create a
codespace → run the prompt → render the qmd → time it). Full checklist in the
seminar project notes (`docs/codespaces-getting-started.md`).
