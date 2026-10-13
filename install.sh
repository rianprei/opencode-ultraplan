#!/usr/bin/env bash
# install.sh — opencode-ultraplan
# One-liner installer: detects runtime, copies the right file.
set -euo pipefail

REPO="rianprei/opencode-ultraplan"
BRANCH="main"

echo "📋 Installing opencode-ultraplan..."

# Detect runtimes
install_opencode() {
  mkdir -p ~/.config/opencode/commands
  cp src/opencode/ultraplan.md ~/.config/opencode/commands/ultraplan.md
  echo "  ✅ opencode: ~/.config/opencode/commands/ultraplan.md"
}

install_claude() {
  mkdir -p ~/.claude/commands
  cp src/claude/ultraplan.md ~/.claude/commands/ultraplan.md
  echo "  ✅ Claude Code: ~/.claude/commands/ultraplan.md"
}

install_codex() {
  mkdir -p ~/.codex/skills/ultraplan
  cp src/codex/SKILL.md ~/.codex/skills/ultraplan/SKILL.md
  echo "  ✅ Codex: ~/.codex/skills/ultraplan/SKILL.md"
}

install_grok() {
  mkdir -p ~/.grok/skills/ultraplan
  cp src/grok/SKILL.md ~/.grok/skills/ultraplan/SKILL.md
  echo "  ✅ Grok Build: ~/.grok/skills/ultraplan/SKILL.md"
}

# If running from the repo (files present), copy directly
if [ -f "src/opencode/ultraplan.md" ]; then
  if command -v opencode >/dev/null 2>&1; then install_opencode; fi
  if [ -d ~/.claude ]; then install_claude; fi
  if command -v codex >/dev/null 2>&1 || [ -d ~/.codex ]; then install_codex; fi
  if command -v grok >/dev/null 2>&1 || [ -d ~/.grok ]; then install_grok; fi
else
  # Download and install
  echo "  Downloading..."
  tmpdir=$(mktemp -d)
  git clone --depth 1 "https://github.com/$REPO.git" "$tmpdir/repo" 2>/dev/null
  cd "$tmpdir/repo"
  if command -v opencode >/dev/null 2>&1; then install_opencode; fi
  if [ -d ~/.claude ]; then install_claude; fi
  if command -v codex >/dev/null 2>&1 || [ -d ~/.codex ]; then install_codex; fi
  if command -v grok >/dev/null 2>&1 || [ -d ~/.grok ]; then install_grok; fi
  cd /
  rm -rf "$tmpdir"
fi

echo ""
echo "  Done. Use: /ultraplan <objective>"
