#!/usr/bin/env bash
set -Eeuo pipefail

FIRESTORM_ROOT="${FIRESTORM_ROOT:-$PWD}"
SRC_ROOT="${SRC_ROOT:-$HOME/src}"
BUILD_VARIABLES_ROOT="${BUILD_VARIABLES_ROOT:-$SRC_ROOT/fs-build-variables}"
BUILD_VARIABLES_COMMIT="c17312d38377c003977cf5b6dcc83c6042eba194"
AUTOBUILD_ROOT="${AUTOBUILD_ROOT:-$SRC_ROOT/autobuild}"
AUTOBUILD_COMMIT="main"
VENV_ROOT="${VENV_ROOT:-$HOME/.venvs/firestorm-build}"
FIRESTORM_RELEASE_REF="Firestorm_Release_7.2.5.81788"
BASELINE_LOG="${BASELINE_LOG:-$HOME/.cache/firestorm-baseline-releasefs-open.log}"

mkdir -p "$SRC_ROOT" "$HOME/.config" "$(dirname "$BASELINE_LOG")"

git -C "$FIRESTORM_ROOT" fetch --tags origin
git -C "$FIRESTORM_ROOT" checkout --detach "$FIRESTORM_RELEASE_REF"

if [[ ! -d "$BUILD_VARIABLES_ROOT/.git" ]]; then
    git clone https://github.com/KaerisTasaan/fs-build-variables.git "$BUILD_VARIABLES_ROOT"
fi
git -C "$BUILD_VARIABLES_ROOT" fetch --tags origin
git -C "$BUILD_VARIABLES_ROOT" checkout --detach "$BUILD_VARIABLES_COMMIT"

if [[ ! -d "$AUTOBUILD_ROOT/.git" ]]; then
    git clone https://github.com/KaerisTasaan/autobuild.git "$AUTOBUILD_ROOT"
fi
git -C "$AUTOBUILD_ROOT" fetch origin "$AUTOBUILD_COMMIT"
git -C "$AUTOBUILD_ROOT" checkout --detach "origin/$AUTOBUILD_COMMIT"

python3 -m venv "$VENV_ROOT"
source "$VENV_ROOT/bin/activate"
python -m pip install --upgrade pip
python -m pip install "$AUTOBUILD_ROOT"
python -m pip install -r "$FIRESTORM_ROOT/requirements.txt"

export AUTOBUILD_VARIABLES_FILE="$BUILD_VARIABLES_ROOT/variables"
export CC=gcc-14
export CXX=g++-14
export PATH="$VENV_ROOT/bin:$PATH"

cat > "$HOME/.config/firestorm-build.env" <<EOF
export FIRESTORM_ROOT=$(printf '%q' "$FIRESTORM_ROOT")
export BUILD_VARIABLES_ROOT=$(printf '%q' "$BUILD_VARIABLES_ROOT")
export AUTOBUILD_VARIABLES_FILE=$(printf '%q' "$AUTOBUILD_VARIABLES_FILE")
export CC=$(printf '%q' "$CC")
export CXX=$(printf '%q' "$CXX")
export PATH=$(printf '%q' "$VENV_ROOT/bin"):\$PATH
EOF

(
    cd "$FIRESTORM_ROOT"
    {
        printf 'Release ref: %s\n' "$FIRESTORM_RELEASE_REF"
        printf 'Release commit: %s\n' "$(git rev-parse HEAD)"
        printf 'Started: %s\n' "$(date --iso-8601=seconds)"
        /usr/bin/time -v "$VENV_ROOT/bin/autobuild" configure -A 64 -c ReleaseFS_open
        /usr/bin/time -v "$VENV_ROOT/bin/autobuild" build -A 64 -c ReleaseFS_open
        printf 'Completed: %s\n' "$(date --iso-8601=seconds)"
    } 2>&1 | tee "$BASELINE_LOG"
)

printf 'Build environment ready.\n'
printf 'Source: %s\n' "$FIRESTORM_ROOT"
printf 'Build variables: %s\n' "$BUILD_VARIABLES_ROOT"
printf 'Autobuild: %s\n' "$("$VENV_ROOT/bin/autobuild" --version)"
printf 'Baseline log: %s\n' "$BASELINE_LOG"
