# PolyLinux Basic data-generation modifications

Apply these files over an unchanged checkout of:

`https://github.com/giacobe/polylinux-basic`

The included `install.sh` is the exact prior version supplied by Nick. It retains the original prompt and helper-install behavior.

This overlay intentionally does not contain or modify:

- `nextlevel`
- `prevlevel`
- `profile` or `.profile`
- any other baseline installation or navigation file

The attached level generators, shared data-generation contracts, catalog mapper,
theme table, and catalog files are included exactly as supplied, except that
`polylinux-parallel-runtime.sh` no longer displays the selected theme in the
generated `README.txt` metadata or in the build-progress message.
