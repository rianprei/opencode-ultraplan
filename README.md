# opencode-ultraplan

> **Local replica of Anthropic's `/ultraplan`** — deep multi-agent planning with adversarial critique, built from the actual leaked source code (npm v2.1.88), the best of 6 open-source replicas, GitHub's spec-kit, and the superpowers methodology. Runs 100% locally (Remote PR only with explicit consent). No cloud quota. No browser. No arbitrary limits.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-5.2-green.svg)](CHANGELOG.md)
[![Runtimes](https://img.shields.io/badge/runtimes-opencode%20%7C%20claude%20%7C%20codex%20%7C%20grok-blueviolet.svg)](#installation)
[![Cloud Free](https://img.shields.io/badge/cloud-free-brightgreen.svg)](#the-ultraplan-is-dead)
[![Quota Free](https://img.shields.io/badge/quota-unlimited-brightgreen.svg)](#the-ultraplan-is-dead)

## The ultraplan is dead

Anthropic shipped `/ultraplan` in Claude Code **v2.1.92** (April 2026) and killed it in **v2.1.222** (July 2026). It was a cloud session where Opus researched for up to 30 minutes with 3 parallel exploration agents + 1 critique agent, producing a plan you reviewed in the browser like a PR.

It's gone. This is the restoration.

## What it does

```
/ultraplan <objective>
```

Spawns a **frota of 3 parallel explorers + 1 adversarial critic** that reads your codebase, hunts for reusable code, tries to break the draft plan, and produces a structured plan with:

- **Complexity routing** (score 4–12 → direct / 3+1 fleet / 3+1 + file-ownership table)
- **`done =` observable criteria per step** — catches fake-progress at step 2 instead of step 10
- **`PRECISA CLARIFICAR` markers** — zero silent guessing
- **Section-by-section revision** — `/ultraplan revise <n>: <feedback>` regenerates ONLY section n
- **3 execution surfaces** — direct / subagent-per-step / remote PR
- **Adversarial critic with refutation loop** — up to 2 rounds, then it's visible, never deadlock

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     /ultraplan <objective>                   │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌─── SETUP ────┐   Scan 3-5 key files BEFORE asking       │
│  │ Terrain first │   Score complexity 4-12 → Rota A/B/C     │
│  └──────┬────────┘                                         │
│         ▼                                                    │
│  ┌─── FIND ─────┐   3 explorers in PARALLEL:                │
│  │ Frota 3 agents│   codebase (reuso!) · risks · tests     │
│  └──────┬────────┘   Each fact: V1|V2|V3 grade             │
│         ▼                                                    │
│  ┌─── VERIFY ───┐   1 adversarial critic (fresh instance): │
│  │ Gate + Critic │   Tries to BREAK the plan.              │
│  │                │   Refuted → fix → re-critic (max 2×). │
│  │                │   Persistent → PRECISA CLARIFICAR.     │
│  └──────┬────────┘                                         │
│         ▼                                                    │
│  ┌─── O PLANO ──┐   7 numbered sections + Fase + Veredito  │
│  │ done= per step│   Section-by-section review:            │
│  │                │   revise <n> · accept · salva · para   │
│  └───────────────┘                                          │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## Installation

### One-liner (any runtime)

```bash
curl -fsSL https://raw.githubusercontent.com/rianprei/opencode-ultraplan/main/install.sh | bash
```

### Manual

| Runtime | File | Destination |
|---|---|---|
| **opencode** | `src/opencode/ultraplan.md` | `~/.config/opencode/commands/ultraplan.md` |
| **Claude Code** | `src/claude/ultraplan.md` | `~/.claude/commands/ultraplan.md` |
| **Codex** | `src/codex/SKILL.md` | `~/.codex/skills/ultraplan/SKILL.md` |
| **Grok Build** | `src/grok/SKILL.md` | `~/.grok/skills/ultraplan/SKILL.md` |

## Usage

```
/ultraplan migra o auth pra OAuth2
/ultraplan refactor the payment module
"refina com ultraplan"            (sobre um plano rascunho)
/ultraplan                         (usage help + verbos)
/ultraplan revise 5: muda pra JWT  (regenera SÓ a seção 5)
/ultraplan accept                  (contrato congelado → executa)
/ultraplan salva                   (persiste .ultraplan/plan.md)
/ultraplan para                    (para anti-sycophancy)
```

## Comparison vs the original

| Feature | Anthropic's `/ultraplan` (dead) | This replica |
|---|---|---|
| Where it runs | Cloud CCR | **100% local** (Remote PR only with consent) |
| Frota | 3 explorers + 1 critic (cloud) | Same 3+1 (subagentes locais) |
| Review | Browser, inline comments | Terminal, `revise <n>` |
| Timeout | 30 min, destroys work | **None** |
| Setup | `/web-setup` + GitHub app + plan | **Zero** |
| Plan persistence | Lost on timeout | **`.ultraplan/plan.md` survives restart** |
| done= per step | No | **Yes** — anti-fake-work |
| Complexity routing | No | **Score 4-12 → Rota A/B/C** |
| Constraints | Cloud allowlist | Local perimeter |
| Cost | $5-25/review in credits | **Free (local tokens only)** |

## What's in the plan format

```markdown
📋 ULTRAPLAN — <objective in 1 line>
Rota: <A|B|C (score X/12)> | Modo: <3+1|sequencial|direto> | Fase: <...> | Revisões: N

## 1. Contexto e terreno (V1/V2/V3 grades; PRECISA CLARIFICAR items)
## 2. Alternativas consideradas (if architectural fork)
## 3. Arquivos a criar
## 4. Arquivos a modificar
## 5. Passos (done= per step + Run/Expected when testable)
## 6. Riscos, premissas e Plano B (rollback in 1 line)
## 7. Condição de verificação (exact command)
```

## The 3 entry points

1. **Command**: `/ultraplan <objective>`
2. **Keyword**: "ultraplan" in a natural request
3. **Refine**: "refina com ultraplan" on an existing draft → frota runs ON the draft

## Provenance

Built from:
- **Anthropic's actual source code** (`ultraplan.tsx`, `ccrSession.ts`, `keyword.ts` — npm v2.1.88 leaked snapshot, publicly mirrored)
- **6 open-source replicas** analyzed: 6missedcalls, youzaiASI, troopdegen, justinwetch, thalisantunes, gemini-cli-ultraplan
- **GitHub spec-kit** (NEEDS CLARIFICATION markers, Constitution Check)
- **Superpowers writing-plans** (TDD steps, Interfaces blocks, self-review, proportion check)
- **Claude Code 2.1.296 binary strings** (destructive-action policy, anti-sycophancy stop)

## Design decisions

| Decision | Why |
|---|---|
| `done =` per step | Justinwetch's anti-fake-work: "defines what counts as done, refuses to call it done without proof" |
| Adversarial critic (not rubber-stamp) | Original's 4th agent; without it, a plan is just a guess with formatting |
| `PRECISA CLARIFICAR` not silent guess | spec-kit's NEEDS CLARIFICATION — never a hidden assumption |
| Section revision, not full regen | The original's browser review worked section-by-section; regenerating all for one fix destroys approved work |
| `.ultraplan/plan.md` persists | Survives context compaction — the original lost work on timeout |
| Complexity routing | youzaiASI: simple tasks don't pay for a fleet; architectural ones get extra armor |

## License

MIT — see [LICENSE](LICENSE)
