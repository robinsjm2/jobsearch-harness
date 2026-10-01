#!/usr/bin/env bash
# Copy the fictional demo persona into a standalone workspace for recordings.
# Usage: ./setup-demo.sh [target-dir]   (default: ~/Projects/jobsearch-demo)
#
# The target must sit outside any folder whose CLAUDE.md/AGENTS.md points at
# your real ~/.jobsearch data, so the demo session never loads it.
set -euo pipefail
src="$(cd "$(dirname "$0")" && pwd)"
dest="${1:-$HOME/Projects/jobsearch-demo}"
if [ -e "$dest" ]; then
  echo "Refusing to overwrite $dest; remove it first for a fresh demo." >&2
  exit 1
fi
mkdir -p "$dest"
cp -R "$src/jobsearch-data" "$src/postings" "$src/CLAUDE.md" "$dest/"
echo "Demo workspace ready: $dest"
echo "Next: cd \"$dest\" && asciinema rec --idle-time-limit 2 demo.cast"
