class KastraMcp < Formula
  desc "Kastra read-only MCP server for Claude Code / Codex"
  homepage "https://github.com/kastra-labs/kastra-edge"
  version "0.13.10" # filled by release.yml on a cli-v* tag
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-mcp-darwin-arm64"
    sha256 "a9fcc611995a937095b00e3726751513065acadaf827843d816e042e46787a68"
  else
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-mcp-darwin-amd64"
    sha256 "d3efeb767d0d1e377d132ce6d150346563ef7de56de09618370c8eb501748772"
  end

  def install
    bin.install Dir["kastra-mcp-*"].first => "kastra-mcp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kastra-mcp --version")
  end
end
