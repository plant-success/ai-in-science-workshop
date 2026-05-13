# Participant guide — driving an AI agent in a real working directory

Welcome. In this exercise you'll use an **AI coding agent** (GitHub Copilot in
"agent mode") that works *inside a real project* — it edits files, runs commands
in a terminal, and fixes its own mistakes. This is the difference between *having
a chat with an AI* and *AI working alongside you on your machine*. You'll get it
to fit a statistical model, write a report explaining it, make some plots, and
check its own work — all in a browser, nothing to install.

---

## Before the session (≈10 min, please do this in advance)

1. **Get a GitHub account** — free, at <https://github.com>. Any email is fine.
2. **(Recommended) Apply for GitHub Education** — <https://education.github.com> —
   it makes **Copilot Pro free** for verified students and staff. *Verification
   can take a day or two, so don't leave it to the morning of.* If you don't have
   it in time, the free Copilot tier is enough for today.

---

## On the day

### 1. Get your own copy of this project
- Open this repo: **`Plant-Success/ai-in-science-workshop`**
- Click the green **`Use this template`** → **`Create a new repository`**
  (owner = your own account; private is fine; name it whatever).
- On *your* new repo, click **`<> Code`** → **`Codespaces`** tab →
  **`Create codespace on main`**.
- Wait for **VS Code to open in your browser**. It should be quick — the
  environment is pre-built with R, Quarto, and Copilot already set up.

### 2. Turn on Copilot agent mode
- If prompted, **sign in to GitHub Copilot** (and accept any "enable Copilot"
  prompt).
- Open the **Copilot Chat** panel — the chat/sparkle icon in the left activity
  bar, or press **`Ctrl/Cmd + Alt + I`**.
- In the chat box, find the **mode dropdown** (it says *Ask* by default) and
  switch it to **`Agent`**.

### 3. Give the agent the task — paste this:

> There is a dataset at `data/plant_growth.csv` (see `data/README.md` for what it
> is). Fit an appropriate **linear mixed-effects model** to it using the `lme4`
> package — choose sensible fixed and random effects and briefly justify them.
> Then write **`analysis.qmd`**, a Quarto document aimed at a reader who has never
> used mixed models, that:
> 1. explains, in plain language, what a **random effect** is and why one is
>    appropriate here;
> 2. loads the data, fits the model, and shows a **tidy summary** with a short
>    interpretation;
> 3. includes at least **two clear `ggplot2` figures** — the raw data showing the
>    group structure, and the fitted/partial effects;
> 4. ends with a short **"validation" section** that simulates a new response from
>    the fitted model, refits, and checks the key parameters are recovered.
>
> Then run `quarto render analysis.qmd`, open the resulting HTML, and fix anything
> that's broken or ugly. Explain what you're doing as you go.

*(There's a skeleton `analysis.qmd` in the repo — the agent can fill it in, or you
can tell it to start fresh.)*

### 4. Work *with* it
- The agent will **propose file edits** (click *Keep*) and **propose terminal
  commands** like `quarto render analysis.qmd` (click *Allow* / *Allow in this
  session*). Watch what it does.
- When it goes wrong or gets stuck, **tell it** — "no, use `lme4::lmer`, not
  `nlme`"; "render it and show me the error"; "the figure axis labels are
  unreadable, fix them". Steering it is the actual skill.
- **View the HTML:** after `quarto render`, use the Quarto extension's
  **Preview** button; or right-click `analysis.html` → **Open with Live Server**
  (that extension is pre-installed); or just download it. Codespaces forwards the
  preview port automatically.

### ✅ You're done when
`analysis.qmd` **and** `analysis.html` both exist, and the HTML reads well:
a plain-language explanation of random effects → a tidy model summary with
interpretation → at least two good plots → a validation section that *actually
runs* and shows the parameters being recovered.

### Stretch goals (if you've got time)
- Ask it to fit the model a **second way** (e.g. `glmmTMB`, or Bayesian with
  `rstanarm`/`brms`) and check the estimates agree with `lme4`.
- Ask it to add a **`testthat` test** for any helper function it wrote.
- Push for **publication-quality figures** (themes, labels, colour).
- Ask it to add `(1 | block)` and compare models — does block matter here?

### Afterwards
You can just close the tab — the codespace stops when idle and is deleted after
30 days. Or delete it now at <https://github.com/codespaces>.

---

## If something breaks
- **Codespace won't create / network errors** — your network may block
  `*.github.dev`; try a different network, or use the Colab fallback the
  presenter has.
- **No Copilot** — make sure you're signed in and Copilot is enabled on your
  account; ask a helper.
- **`quarto render` fails** — read the error with the agent ("here's the error,
  fix it"); 90% of the time it's a missing package or a typo it can sort out.
- **HTML won't preview** — download `analysis.html` and open it locally, or run
  `python3 -m http.server` in the terminal and open the forwarded port.
