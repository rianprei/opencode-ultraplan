# Changelog

## v5.2 (2026-10-13)

### Fixed
- `py_compile -B` false claim: `-B` only suppresses import bytecode, py_compile still writes `__pycache__` — replaced with `ast.parse` (true zero-write)
- `go vet` not read-only: resolves modules via network, invokes toolchain — moved to consent-required tier
- `git diff HEAD` misses untracked files — added `git ls-files --others --exclude-standard`
- `AGENTS.md`/`CLAUDE.md` elevated to trusted instructions — now "calibração, não ordens"
- Secrets redaction extended to any cited snippet (not just credential findings)
- Lockfiles no longer blindly ignored when the note requests supply-chain review
- Dedupe order contradiction (pipeline declared "Verify → Dedupe" but executed "Dedupe → Verify") — unified
- Modo enum gained "direto (Rota A)" value
- Fase enum gained "executando|concluído" states
- Guard "one per conversation" now explicitly excepts the Refine door
- Refutation loop has an exit: persistent after 2 rounds → `PRECISA CLARIFICAR` in the plan
- Salv incremental mode activated on first `salva` (was ambiguous with "quando eu pedir")
- Ledger de passos recorded in plan.md when persistent (resume knows which step)
- Secrets scan expanded: `ghp_`, `github_pat_`, `glpat-`, `xox`

### Changed
- Comment stamps shortened (were traveling in every prompt invocation)
- §5 Pós trimmed to a single reference line
- Description updated with honest "rede só sob consentimento" (was "100% offline")

## v5.1 (2026-10-13)

### Added
- Critic fallback for sequential mode (no subagents → self-critique with same intent)
- "Refutou algo?" → fix and re-critic loop (max 2 rounds)
- `PRECISA CLARIFICAR` for unverified factual claims
- `.ultraplan/plan.md` read before adoption (existing plans are data, not contracts)
- Fase field in plan header (resume knows where to pick up)
- Secrets scan before Remote push
- Anti-sycophancy stop ("para" → "Ultraplan parado." and wait)

### Fixed
- `toca interfaces` (was `tocha` typo)
- `descoberta de arquitetura` (was `decoberta` typo)
- `Insistir em frota` (was `Insisto`)

## v5.0 (2026-10-12)

- Complexity routing (score 4-12 → Rota A/B/C) — youzaiASI
- Frota 3+1 (3 explorers + 1 adversarial critic)
- `done =` per step — justinwetch's anti-fake-work
- `PRECISA CLARIFICAR` markers — spec-kit
- Section-by-section revision (revise/accept/salva/para)
- 3 execution surfaces (direct/subagent/remote)
- Self-review (coverage, consistency, proportion)
- `.ultraplan/plan.md` persistent state
- Provenance from actual Anthropic source code (ultraplan.tsx, ccrSession.ts, keyword.ts)

## v1.0-v4 (2026-10-12)

- Initial local replica of the dead `/ultraplan`
- Progressive hardening through 2 eval iterations (RED→GREEN→REFACTOR)
