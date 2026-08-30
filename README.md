# PolyLinux Lab 1: Basic File System Navigation

This repository preserves the Basic exercise payload recovered from the live
PolyLinux Lab 1 initrd on 2026-08-29. It contains the installer, ten Basic level
generators, required dictionaries, navigation helpers, login profile, and the
published participant instructions.

The source is intentionally preserved as deployed. It is a legacy baseline and
does not yet implement the current PolyLinux exercise-code, testing, solver,
answer-storage, or documentation contracts.

See `PROVENANCE.md` before modifying or repackaging the exercise.

## Repository contents

- `install.sh` installs the recovered lab in a compatible PolyLinux guest.
- `level1.sh` through `level10.sh` generate the ten learner levels.
- `dictionaries/` contains the word data used by the generators.
- `participant-guide.md` preserves the public instructions.
- `provenance/RECOVERY-MANIFEST.json` records the recovered `/root` inventory.

Lab-specific VM images are intentionally excluded and deployed separately.

## License

Licensed under the GNU General Public License v3.0. See `LICENSE`.

## Build the browser VM

This lab uses the `basic` configuration from
[`giacobe/buildroot-builder2`](https://github.com/giacobe/buildroot-builder2),
validated with Buildroot `2025.02.15`. On a Linux build host:

```sh
git clone https://github.com/giacobe/buildroot-builder2.git
cd buildroot-builder2
BUILDROOT_VERSION=2025.02.15 scripts/01-setup-buildroot.sh
scripts/02-build-baseline.sh --config basic
scripts/03-package-payload.sh \
  --repo https://github.com/giacobe/polylinux-basic.git \
  --ref main \
  --baseline artifacts/basic-<timestamp> \
  --output artifacts/polylinux-basic \
  --output-prefix polylinux-basic
```

Replace `<timestamp>` with the directory created by stage 2. Before publishing,
review the generated manifest and boot-test the exact `.bzImage` and
`.rootfs.cpio.gz` pair in v86. Do not commit those generated images here.

## Standard runtime contract

The current release uses the reversible PolyBandit exercise code, the versioned `seed-v1` deterministic seed, ten concurrent level generators, staged `README.txt` readiness, unrestricted `nextlevel`/`prevlevel` navigation, and no client-side answer store or checker. See `lab.json` for the authoritative level count, theme policy, Buildroot configuration, and browser artifact names.

Do not rebuild the assigned Buildroot baseline merely to package this lab. Package the repository payload into the configuration named by `buildroot_configuration`, preserve the baseline kernel, and publish the resulting `packaged.bzImage` and `packaged.rootfs.cpio.gz`.
