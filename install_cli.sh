#!/usr/bin/env bash

# License: MIT

# Neterial Cross-Platform CLI installer script
# Supports:
# - Linux (primarily Ubuntu, including WSL)
# - macOS via Homebrew

set -euo pipefail

# Print error message and exit
die() {
    echo "Error: $*" >&2
    exit 1
}

# Detect OS
OS=$(uname -s | tr '[:upper:]' '[:lower:]')

# macOS (Darwin) specific installation
if [ "$OS" = "darwin" ]; then
    echo "→ Detected macOS system"

    # Check if Homebrew is installed
    if ! command -v brew >/dev/null 2>&1; then
        echo "⚠️  Homebrew is required on macOS. Please install it from https://brew.sh" >&2
        exit 1
    fi

    echo "→ Installing neterial via Homebrew..."
    brew tap neterialio/tap || die "Failed to tap neterialio/tap"
    brew install neterial-cli || die "Failed to install neterial-cli"

    # Verify installation
    if command -v neterial >/dev/null 2>&1; then
        echo "✅ neterial installed successfully via Homebrew"
        neterial --version
        echo
        echo "🚀 You can now use the 'neterial' command"
    else
        die "Installation appeared to succeed but 'neterial' command not found"
    fi

    exit 0
fi

# Linux installation
if [ "$OS" != "linux" ]; then
    die "Unsupported operating system: $OS. This installer supports Linux and macOS only."
fi

# Linux-specific installation below
echo "→ Detected Linux system"

### 1. Installation prefix (override with PREFIX=/some/where)
PREFIX=${PREFIX:-$HOME/.local}
BINDIR="$PREFIX/bin"

### 2. Compute & create all needed directories
COMPDIR="${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/completions"
mkdir -p "$HOME/bin" "$BINDIR" "$COMPDIR"

### 3. Make new bin dir available for future non-login shells
# Auto-append to ~/.bashrc if not already present
if [ -w "$HOME/.bashrc" ] && ! grep -Fq 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc"; then
    printf '\n# add neterial installer bin dir\nexport PATH="$HOME/.local/bin:$PATH"\n' >> "$HOME/.bashrc"
fi

### 4. Detect ARCH, error on unsupported
ARCH=$(uname -m)
case "$ARCH" in
    x86_64|amd64) ARCH=amd64 ;;
    aarch64|arm64) ARCH=arm64 ;;
    *)
        die "Unsupported architecture '$ARCH'"
        ;;
esac

### 5. Ensure required tools exist
for cmd in curl tar; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        die "'$cmd' is required but not found. Please install it and re-run."
    fi
done

### 6. Download & extract with failure checks
VERSION=${VERSION:-"v0.3.0"}     # override as needed
REPO="github.com/neterialio/cli"
TARBALL="neterial-${VERSION}-${OS}-${ARCH}.tar.gz"
URL="https://${REPO}/releases/download/${VERSION}/${TARBALL}"

echo "→ Downloading neterial ${VERSION} for ${OS}/${ARCH} from:"
echo "   $URL"

if ! curl --fail --silent --show-error --location "$URL" | tar xz -C "$BINDIR"; then
    die "Download or extraction failed"
fi

chmod +x "$BINDIR/neterial"

### 7. Generate & install Bash completion
echo "→ Generating Bash completion script..."
if ! "$BINDIR/neterial" completion bash > "$COMPDIR/neterial"; then
    echo "⚠️  Warning: failed to generate completion; skipping." >&2
else
    echo "→ Installed Bash completion to $COMPDIR/neterial"
fi

### 8. Check for bash-completion package
if [ ! -f "/etc/bash_completion" ] && [ ! -d "/usr/share/bash-completion" ]; then
    echo
    echo "⚠️  You don't appear to have the 'bash-completion' package installed."
    echo "   To enable completions on new shells, run: sudo apt install bash-completion"
fi

### 9. Final message
cat <<EOF

✅  neterial ${VERSION} installed to:
    $BINDIR/neterial

📜  Bash completion script:
    $COMPDIR/neterial

🚀  Usage:
    • To use right now, run:

    source ~/.bashrc

    (or restart your shell)

🔧  Overrides (Linux only):
    • PREFIX=/your/path bash install_linux_cli.sh
    • VERSION=vX.Y.Z bash install_linux_cli.sh

Enjoy! 🎉
EOF
