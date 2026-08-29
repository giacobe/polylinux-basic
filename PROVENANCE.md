# Recovery provenance

- Lab: 1, Basic File System Navigation
- Live initrd: `https://polylab.ist.psu.edu/polylinux/lab1/rootfs.cpio.gz`
- Initrd SHA-256: `3354ed6f0025d6486b9a11554f1da7db1df0b6e09e798c65fa404f2bf783e45f`
- Recovery date: 2026-08-29
- Recovered boundary: `/root`

The live `/root` contained Basic, Bandit, and historical file-manipulation
material. This repository includes only the Basic installer, `basic1.sh` through
`basic10.sh`, their dictionaries, and direct runtime helpers. Unrelated exercises
were deliberately excluded.

The 15 assessed Basic installer/generator/navigation files matched the historical
local `sources/polybandit3-main` copies exactly. The original complete `/root`
entry manifest is retained at `provenance/RECOVERY-MANIFEST.json`.
