class KastraEdge < Formula
  desc "Kastra Edge clients (kastrahook, kastra-mcp, kastra-edge CLI)"
  homepage "https://github.com/kastra-labs/kastra-edge"
  version "0.2.13" # filled by release.yml on a cli-v* tag
  license :cannot_represent

  # Published to the PUBLIC kastra-edge-releases repo (kastra-edge source is
  # private; credential-less Homebrew can only fetch public assets).
  # version + sha256 are filled by .github/workflows/release.yml.
  if Hardware::CPU.arm?
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-edge-bundle-darwin-arm64.tar.gz"
    sha256 "f1b4903666acf41968474eb109415c181d2170c052a253b826b0345c71d13cc3"
  else
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-edge-bundle-darwin-amd64.tar.gz"
    sha256 "15feb6cdd21c9d9f9cc6dc9e6bbf0216d7a8ed34a8e7fde0a6040ba8ac784cce"
  end

  def install
    bin.install "kastrahook"
    bin.install "kastra-edge"
    bin.install "kastra-mcp"
  end

  def caveats
    <<~EOS
      Kastra Edge installed. Next steps:
        1. kastra-edge login           # authorize this device in your browser
        2. kastra-edge install-mcp     # wire kastra-mcp into Claude Code
        3. kastra-edge install-codex   # (optional) wire into Codex

      Restart Claude Code / Codex to pick up the MCP.

      Note: these binaries are not yet Apple-notarized. If macOS Gatekeeper
      blocks a binary on first run, clear its quarantine flag, e.g.:
        xattr -d com.apple.quarantine "$(brew --prefix)/bin/kastra-edge"
    EOS
  end

  test do
    # kastra-edge / kastrahook are subcommand- and stdin-driven (no --version);
    # kastra-mcp is the one CLI with a --version flag.
    assert_match version.to_s, shell_output("#{bin}/kastra-mcp --version")
    assert_predicate bin/"kastra-edge", :executable?
    assert_predicate bin/"kastrahook", :executable?
  end
end
