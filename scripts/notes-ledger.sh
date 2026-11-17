#!/usr/bin/env bash
# Print the sweep ledger skeleton: one line per note in every memory root.
# Settle runs this first and fills the remaining columns (visible?
# contradicted? bet? right root? action). Deterministic; no inference.
#
# Usage: scripts/notes-ledger.sh [user-clone-root]   (default: repo of this script)
set -u
root="${1:-$(cd "$(dirname "$0")/.." && pwd)}"
M="$root/agent-memory"
[ -d "$M" ] || { echo "no agent-memory under $root" >&2; exit 1; }

fm() { # <file> <key> → frontmatter value or "-"
  awk -v k="$2" 'NR==1 && $0!="---"{exit} NR>1 && $0=="---"{exit} NR>1 && index($0,k":")==1{sub("^"k":[ ]*",""); print; found=1; exit} END{if(!found) print "-"}' "$1"
}

printf '| note | root | status | origin | made | visible? | contradicted? | bet? | right root? | action |\n'
printf '|---|---|---|---|---|---|---|---|---|---|\n'
find "$M" -type f -name '*.md' \
  ! -name 'MEMORY.md' ! -name 'issues.md' ! -name 'dream-log.md' \
  ! -path '*/wiki/*' ! -path '*/_retired/*' | sort | while read -r f; do
  rel="${f#$M/}"
  r="${rel%%/*}"; [ "$r" = "_main" ] && r="_main/$(printf '%s' "$rel" | cut -d/ -f2)"
  # a one-line stub left by a move is not a note
  if [ "$(grep -cv '^[[:space:]]*$' "$f")" -le 2 ] && grep -qi 'moved to' "$f"; then continue; fi
  printf '| %s | %s | %s | %s | %s |  |  |  |  |  |\n' "$rel" "$r" "$(fm "$f" status)" "$(fm "$f" origin)" "$(fm "$f" made)"
done
