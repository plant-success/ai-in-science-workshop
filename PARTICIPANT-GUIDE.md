# Participant guide — driving an AI agent in a real working directory

Welcome. In this exercise you'll use an **AI coding agent** (GitHub Copilot in
"agent mode") that works *inside a real project* — it edits files, runs commands
in a terminal, and fixes its own mistakes. This is the difference between *having
a chat with an AI* and *AI working alongside you on your machine*. You'll get it
to fit a statistical model, write a report explaining it, make some plots, and
check its own work — all in a browser, nothing to install.

---

## Before the session (≈10 min, please do this in advance — it makes the day much smoother)

1. **Get a GitHub account** — free, at <https://github.com>. Any email is fine.
2. **Turn on GitHub Copilot _on your account_, ahead of time.** Go to
   <https://github.com/settings/copilot>, enable **Copilot Free** (or Pro/Education
   if you have it), and accept the terms. Doing this *now*, once, on your account
   is the single best way to avoid the most common hiccup on the day — see step 2
   under "On the day".
3. **(Optional but nice) Do a 2-minute dry run.** Open
   `Plant-Success/ai-in-science-workshop` → **`<> Code`** → **`Codespaces`** →
   **`Create codespace on main`**, let it open, and when Copilot prompts you,
   complete the sign-in/consent. Then close it. Now Copilot is fully authorised
   for your account and future codespaces start clean.
4. **(Optional) Apply for GitHub Education** — <https://education.github.com> —
   it makes **Copilot Pro free** for verified students and staff. *Verification
   can take a day or two, so don't leave it to the morning of.* The free Copilot
   tier is enough for today regardless.

---

## On the day

> Tip: do steps 1–2 **as soon as you sit down** (during the intro). The first
> launch takes a couple of minutes, so get it going early.

### 1. Launch your codespace
- Open the repo **`Plant-Success/ai-in-science-workshop`**.
- Click **`<> Code`** → **`Codespaces`** tab → **`Create codespace on main`**.
- Wait for **VS Code to open in your browser** (~1–3 min the first time — it's
  pulling a ready-made environment with R, Quarto and Copilot baked in).
- This is a shared repo — your codespace is your own private sandbox, so just
  work in it; **don't `git push`** to the repo. *(Want your own copy to keep?
  Use the green "Use this template" button on the repo first — optional.)*

### 2. Get Copilot working — do this **before** anything else
This is the step that occasionally gets stuck; here's how to get it right:
- When VS Code opens, you'll likely get a prompt to **enable AI features / sign
  in to GitHub Copilot** — **say yes / sign in** and let it finish. (If you did
  the "before the session" steps, this is quick or doesn't appear.)
- Open **Copilot Chat** — the chat/sparkle icon in the left activity bar, or
  **`Ctrl/Cmd + Alt + I`**.
- **If Copilot Chat looks stuck, blank, or "initialising" and won't respond:**
  open the Command Palette (**`Ctrl/Cmd + Shift + P`**) → run
  **`Developer: Reload Window`**. That reloads the editor in ~5 seconds and
  almost always clears it. ⚠️ *Don't* delete/recreate the codespace for this —
  a reload is all it needs.
- Once Chat responds: in the chat box find the **mode dropdown** (it says *Ask*
  by default) and switch it to **`Agent`**.

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
- **Copilot Chat is stuck / blank / "initialising", or just won't respond after
  you enabled AI tools** — Command Palette (`Ctrl/Cmd+Shift+P`) →
  **`Developer: Reload Window`**. Fixes it ~95% of the time in a few seconds.
  *Don't* recreate the codespace for this.
- **Still no Copilot after a reload** — check you're signed in and Copilot is
  enabled on your account at <https://github.com/settings/copilot>; sign out/in
  of GitHub in VS Code (Accounts icon, bottom-left); ask a helper.
- **Codespace won't create / network errors** — your network may block
  `*.github.dev`; try a different network, or use the Colab fallback the
  presenter has.
- **`quarto render` fails** — read the error with the agent ("here's the error,
  fix it"); 90% of the time it's a missing package or a typo it can sort out.
- **HTML won't preview** — download `analysis.html` and open it locally, or run
  `python3 -m http.server` in the terminal and open the forwarded port.
