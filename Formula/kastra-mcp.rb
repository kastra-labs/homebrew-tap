class KastraMcp < Formula
  desc "Kastra read-only MCP server for Claude Code / Codex"
  homepage "https://github.com/kastra-labs/kastra-edge"
  version "0.11.0" # filled by release.yml on a cli-v* tag
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-mcp-darwin-arm64"
    sha256 "748ea2c2172a514bf2fc1dbfe739d3335ca6488e7ad943c87e497c1b6efcb359"
  else
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-mcp-darwin-amd64"
    sha256 "f9b6f24ac50e997bc153e8d23d5b4ba2a08ea1cf1cd30033e0c553ddd53d4344"
  end

  def install
    bin.install Dir["kastra-mcp-*"].first => "kastra-mcp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kastra-mcp --version")
  end
end
