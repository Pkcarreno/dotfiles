# dotfiles

Managed with [mise](https://mise.jdx.dev/).

Core tools and terminal utilities are automatically provisioned and managed by `mise` across Linux and Windows (`neovim`, `helix`, `fish`, `herdr`, `ripgrep`, `fd`, `zoxide`, `eza`, `bat`, `delta`).

## Prerequisites

- `git`
- `mise`
- **Windows only:** PowerShell 7 (`pwsh`)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/pkcarreno/dotfiles.git ~/.dotfiles
   # Or via SSH:
   git clone git@github.com:pkcarreno/dotfiles.git ~/.dotfiles
  ```

2. Run bootstrap specifying your target environment (e.g., `desktop`, `server`):
  ```bash
  mise bootstrap -E <env> --from https://github.com/pkcarreno/dotfiles
  ```

(Tip: Add `--plan` to preview actions before applying).

Note: This setup relies on `mise dotfiles`, which is currently experimental and undergoing active development upstream.
