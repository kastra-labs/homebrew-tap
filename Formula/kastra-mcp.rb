class KastraMcp < Formula
  desc "Kastra read-only MCP server for Claude Code / Codex"
  homepage "https://github.com/kastra-labs/kastra-edge"
  version "0.2.0"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-mcp-darwin-arm64"
    sha256 "ae5eb0fc1ad06e7feca4cd92db384314c29a022204e07428e56b16a637e8d2c4"
  else
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-mcp-darwin-amd64"
    sha256 "b33f8933878f14d0411b695d996b57cd071e7787a41a351f14c854f74ed8bad7"
  end

  def install
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "kastra-mcp-darwin-#{arch}" => "kastra-mcp"
  end

  test do
    assert_match "0.2.0", shell_output("#{bin}/kastra-mcp --version")
  end
end
