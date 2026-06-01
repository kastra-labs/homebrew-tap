# Kastra Homebrew Tap

Homebrew formulae for the [Kastra Edge](https://github.com/kastra-labs/kastra-edge) clients.

```sh
brew install kastra-labs/tap/kastra-edge
```

This installs the three CLIs — `kastra-edge`, `kastrahook`, and `kastra-mcp`. Then:

```sh
kastra-edge login          # authorize this device
kastra-edge install-mcp    # wire kastra-mcp into Claude Code
kastra-edge install-codex  # (optional) wire into Codex
```

Restart Claude Code / Codex to pick up the MCP.

## Formulae

| Formula | Installs |
|---------|----------|
| `kastra-edge` | all three CLIs (recommended) |
| `kastra-mcp` | just the read-only MCP server |
| `kastrahook` | just the policy hook |

Binaries are published to the public [`kastra-edge-releases`](https://github.com/kastra-labs/kastra-edge-releases) repo (macOS arm64 + amd64). They are not yet Apple-notarized; if Gatekeeper blocks one, clear quarantine with `xattr -d com.apple.quarantine "$(brew --prefix)/bin/<binary>"`.
