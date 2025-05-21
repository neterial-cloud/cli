# Installing the Neterial CLI

⚠️ **Note:** The installation script is currently experimental.
Use it with caution and review the script before running.

## Quick Install (Linux, macOS, and Windows WSL)

This method works on Linux, macOS, and Windows Subsystem for Linux (WSL):

```sh
curl -sSL https://raw.githubusercontent.com/neterialio/cli/refs/heads/main/install_cli.sh | bash
```

Restart your shell or run:

```sh
source ~/.bashrc
```

Check:

```sh
neterial -h
```

## Platform-Specific Installation

### macOS (Homebrew Required)

```sh
brew tap neterialio/tap
brew install neterial-cli
```

Check:

```sh
neterial -h
```

### Windows (WSL Required)

Open the Windows command prompt by typing `cmd` in the Windows search bar and tap Enter.

Run to ensure Linux installed:

```sh
wsl --install
```

Or if Linux distro already installed:

```sh
wsl
```

Run in the Linux terminal:

```sh
curl -sSL https://raw.githubusercontent.com/neterialio/cli/refs/heads/main/install_cli.sh | bash
```

Restart your shell or run:

```sh
source ~/.bashrc
```

Check:

```sh
neterial -h
```

### Arch Linux

```sh
git clone https://github.com/neterialio/cli.git
cd cli
makepkg -si
```

Note: Ensure you have `base-devel` and `git` installed before running the above.

Check:

```sh
neterial -h
```

