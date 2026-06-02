class KastraMcp < Formula
  desc "Kastra read-only MCP server for Claude Code / Codex"
  homepage "https://github.com/kastra-labs/kastra-edge"
  version "0.2.5" # filled by release.yml on a cli-v* tag
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-mcp-darwin-arm64"
    sha256 "56c71d5b379b0c86e57deb6853c58a5bf9d6efedf6ed14d0d28799b9a6a4a580"
  else
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-mcp-darwin-amd64"
    sha256 "40d36b3a71a9c58bae6e25fd4f79c9b0d804b1ea9b3b26cb4e26e64f4ef91cef"
  end

  def install
    bin.install Dir["kastra-mcp-*"].first => "kastra-mcp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kastra-mcp --version")
  end
end
