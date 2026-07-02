class KastraMcp < Formula
  desc "Kastra read-only MCP server for Claude Code / Codex"
  homepage "https://github.com/kastra-labs/kastra-edge"
  version "0.3.3" # filled by release.yml on a cli-v* tag
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-mcp-darwin-arm64"
    sha256 "23e6cfcfd135e7ce3cbe17c258c1ebbf55d62783520199abf1a4e7afa473310a"
  else
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-mcp-darwin-amd64"
    sha256 "eb305f1845555bb267ea44b11130fb3eacfa17eff0d09b25d37127119d8e6617"
  end

  def install
    bin.install Dir["kastra-mcp-*"].first => "kastra-mcp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kastra-mcp --version")
  end
end
