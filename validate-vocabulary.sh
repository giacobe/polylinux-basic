#!/bin/sh
set -eu
cd "$(dirname "$0")"
failed=0
tmp=${TMPDIR:-/tmp}/polylinux-vocab.$$
trap 'rm -rf "$tmp"' EXIT HUP INT TERM
mkdir -p "$tmp"
list_count=$(find catalog -type f -name '*.txt' | wc -l | tr -d ' ')
[ "$list_count" -eq 16 ] || { echo "Expected 16 lists; found $list_count"; failed=1; }
for file in catalog/*.txt; do
 count=$(wc -l < "$file" | tr -d ' ')
 [ "$count" -eq 16 ] || { echo "$file: expected 16 items; found $count"; failed=1; }
 LC_ALL=C sort "$file" | uniq -d > "$tmp/duplicates"
 [ ! -s "$tmp/duplicates" ] || { echo "$file: duplicate entries"; failed=1; }
 grep -nEv '^[a-z][a-z0-9_]*$' "$file" > "$tmp/unsafe" || true
 [ ! -s "$tmp/unsafe" ] || { echo "$file: unsafe tokens"; cat "$tmp/unsafe"; failed=1; }
done
cat catalog/*.txt | LC_ALL=C sort | uniq -d > "$tmp/cross"
[ ! -s "$tmp/cross" ] || { echo 'Tokens repeated across lists:'; cat "$tmp/cross"; failed=1; }
[ "$failed" -eq 0 ] || exit 1
echo 'PASS: 16 lists, 16 items each, 256 globally unique safe tokens.'
echo 'NOTE: semantic and ESL accessibility review remains a human test.'
