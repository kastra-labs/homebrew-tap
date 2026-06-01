class Kastrahook < Formula
  desc "Kastra policy hook for Claude Code / Codex (PreToolUse enforcement)"
  homepage "https://github.com/kastra-labs/kastra-edge"
  version "0.2.0"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastrahook-darwin-arm64"
    sha256 "48f0c3c54c67b0e53a83226f1f8165fb1e7a80cae24320dea03ead587ee277c6"
  else
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastrahook-darwin-amd64"
    sha256 "b9fccddb59bc3136c40576f97eb20cd66225dc92d681468e6392cc08063fe561"
  end

  def install
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "kastrahook-darwin-#{arch}" => "kastrahook"
  end

  test do
    # kastrahook reads a JSON hook event on stdin and has no --version flag.
    assert_predicate bin/"kastrahook", :executable?
  end
end
