class KastraMcp < Formula
  desc "Kastra read-only MCP server for Claude Code / Codex"
  homepage "https://github.com/kastra-labs/kastra-edge"
  version "0.6.0" # filled by release.yml on a cli-v* tag
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-mcp-darwin-arm64"
    sha256 "93a12bb2129cddbbb42ff6a027e3fc1036f3b827e3756f2f622230f84be9e4bc"
  else
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-mcp-darwin-amd64"
    sha256 "a3ca7f348380337dc14e71020a4f360284deff0cbecdd1f3b4c507d326655f4f"
  end

  def install
    bin.install Dir["kastra-mcp-*"].first => "kastra-mcp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kastra-mcp --version")
  end
end
