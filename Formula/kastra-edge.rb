class KastraEdge < Formula
  desc "Kastra Edge clients (kastrahook, kastra-mcp, kastra-mcp-gateway, kastra-edge CLI)"
  homepage "https://github.com/kastra-labs/kastra-edge"
  version "0.8.0" # filled by release.yml on a cli-v* tag
  license :cannot_represent

  # Published to the PUBLIC kastra-edge-releases repo (kastra-edge source is
  # private; credential-less Homebrew can only fetch public assets).
  # version + sha256 are filled by .github/workflows/release.yml.
  if Hardware::CPU.arm?
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-edge-bundle-darwin-arm64.tar.gz"
    sha256 "89557006d0116f03e47214f5302495ba549d8081f5884e54babc4d66dda620a5"
  else
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-edge-bundle-darwin-amd64.tar.gz"
    sha256 "0cd6aca9d0b6998d49b45789ab2a32aa8ae8b5d64b58b2e2f19189fa453ec69e"
  end

  def install
    bin.install "kastrahook"
    bin.install "kastra-edge"
    bin.install "kastra-mcp"
    bin.install "kastra-mcp-gateway"
  end

  def caveats
    <<~EOS
      Kastra Edge installed. Next steps:
        1. kastra-edge login           # authorize this device in your browser
        2. kastra-edge install-mcp     # wire kastra-mcp into Claude Code
        3. kastra-edge install-codex   # (optional) wire into Codex
        4. kastra-edge wrap-claude-desktop  # (optional) govern Claude Desktop's
                                              local MCP servers via kastra-mcp-gateway

      Restart Claude Code / Codex to pick up the MCP. Restart Claude Desktop
      (Cmd+Q, then reopen) after wrap-claude-desktop.

      Note: these binaries are not yet Apple-notarized. If macOS Gatekeeper
      blocks a binary on first run, clear its quarantine flag, e.g.:
        xattr -d com.apple.quarantine "$(brew --prefix)/bin/kastra-edge"
    EOS
  end

  test do
    # kastra-edge / kastrahook are subcommand- and stdin-driven (no --version);
    # kastra-mcp is the one CLI with a --version flag; kastra-mcp-gateway has
    # a `version` subcommand (required by kastra-edge sync-binaries' gate).
    assert_match version.to_s, shell_output("#{bin}/kastra-mcp --version")
    assert_match version.to_s, shell_output("#{bin}/kastra-mcp-gateway version")
    assert_predicate bin/"kastra-edge", :executable?
    assert_predicate bin/"kastrahook", :executable?
  end
end
