#!/bin/sh
# Source after polylinux-common.sh. Replaces its theme catalog/materializer.
THEME_CATALOG_VERSION=themes-v2
export THEME_CATALOG_VERSION
theme_record() { awk -F '\t' -v id="$THEME_HEX" '$1==id {print; exit}' "$INSTALL_ROOT/themes.tsv"; }
theme_field() {
    record=$(theme_record)
    case "$1" in id) printf '%s\n' "$record" | cut -f2;; title) printf '%s\n' "$record" | cut -f3;; *) poly_die "unknown theme field: $1";; esac
}
prepare_theme_dictionaries() {
    destination=$1
    record=$(theme_record)
    [ -n "$record" ] || poly_die "theme not found: $THEME_HEX"
    rm -rf "$destination"; mkdir -p "$destination"
    n=0
    while [ "$n" -lt 16 ]; do
        category=$(printf '%s\n' "$record" | cut -f$((n + 4)))
        key=$(printf '%x' "$n")
        cp "$INSTALL_ROOT/catalog/$category.txt" "$destination/dict$key.txt"
        n=$((n + 1))
    done
}
