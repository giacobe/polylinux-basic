#!/bin/sh
set -eu
cd "$(dirname "$0")"
. ./polylinux-common.sh

LAB_ID=${LAB_ID:-polylinux-basic}
USER_ID=$(normalize_email '  Student@Example.EDU  ')
currentDate=2026-08-30
SYSTEM_PASSWORD='systemPassword'
levelPassword='levelPassword1'
levelnumber=1
export LAB_ID USER_ID currentDate SYSTEM_PASSWORD levelPassword levelnumber

[ "$USER_ID" = 'student@example.edu' ]
[ "$(exercise_code_from_date "$currentDate")" = '13527DE' ]
seed_a=$(level_seed_v1)
seed_b=$(level_seed_v1)
[ "$seed_a" = "$seed_b" ]

seen='|'
index=0
dictionary_root="${TMPDIR:-/tmp}/polylinux-basic-test-$$/theme-dictionaries"
while [ "$index" -lt 16 ]; do
    THEME_INDEX=$index
    export THEME_INDEX
    id=$(theme_field id)
    case "$seen" in *"|$id|"*) echo "duplicate theme id: $id" >&2; exit 1 ;; esac
    seen="$seen$id|"
    for field in title org place system project asset event status service host file person; do
        [ -n "$(theme_field "$field")" ]
    done
    prepare_theme_dictionaries "$dictionary_root"
    [ "$(find "$dictionary_root" -type f | wc -l)" -eq 16 ]
    for key in 0 1 2 3 4 5 6 7 8 9 a b c d e f; do
        [ "$(wc -l < "$dictionary_root/dict$key.txt")" -eq 16 ]
    done
    [ "$(cat "$dictionary_root"/dict*.txt | sort -u | wc -l)" -eq 256 ]
    index=$((index + 1))
done
rm -rf "${dictionary_root%/theme-dictionaries}"

for level in 1 2 3 4 5 6 7 8 9 10; do
    sh -n "./level$level.sh"
done
sh -n ./install.sh ./resources.sh ./polylinux-common.sh ./polylinux-parallel-runtime.sh

if grep -R -n -E 'record_answer|ANSWER_DIR|/answers|checklevel' . \
    --exclude-dir=.git --exclude-dir=provenance --exclude=README.md --exclude=LEVELS.md \
    --exclude=participant-guide.md --exclude=test.sh --exclude=verify.sh; then
    echo 'client-side answer-key reference remains' >&2
    exit 1
fi
if grep -R -n 'theme-context\.txt' . --exclude-dir=.git --exclude=test.sh; then
    echo 'redundant theme-context file generation remains' >&2
    exit 1
fi
echo 'Contract, theme catalog, and shell syntax checks passed.'
