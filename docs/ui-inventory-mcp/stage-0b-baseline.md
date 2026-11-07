# UI inventory MCP stage 0b baseline

Recorded 2026-11-07 15:36 GMT.

## Source revisions

| Repository | Revision |
| --- | --- |
| Firestorm | `4ac201fdc56127de27de34567286885f4e75d194` (`Firestorm_Release_7.2.5.81788`) |
| Outleap | `d57bf45de189faca3828847bb9f28f6ea20083fa` (`v0.9.0`) |
| Build variables | `c17312d38377c003977cf5b6dcc83c6042eba194` |
| Autobuild | `2f0209aecdec6d094d2ac0317969f105e9229843` |

## Environment

- Ubuntu 22.04 x86_64
- 4 CPUs
- 251 GB filesystem, 216 GB free after the build
- GCC 11.4.0
- CMake 3.22.1
- Ninja 1.10.1
- Python 3.10.12
- Autobuild `0.1.dev986`
- LLSD `1.2.4`

## Baseline result

The unmodified `ReleaseFS_open` configure and build passed:

- Configure elapsed time: 1:45.91
- Build elapsed time: 46:38.09
- Configure peak RSS: 225636 kB
- Build peak RSS: 7807336 kB
- Build exit status: 0
- Package: `Phoenix-FirestormOS-private-cursor_LEGACY-7-2-5-81788.tar.xz`
- Package size: 191 MB
- Build tree size: 19 GB

The build used the release-compatible build variables checkout at
`/root/src/fs-build-variables`. The full baseline log is retained at
`/root/.cache/firestorm-baseline-releasefs-open.log`.

## Stage result

The Linux baseline build gate passed. The package is available in the build
tree for artifact staging. Remote Cloud Artifact registration and the LEAP
viewer smoke launch remain follow-up work.
