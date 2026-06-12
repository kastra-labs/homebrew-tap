class Kastrahook < Formula
  desc "Kastra policy hook for Claude Code / Codex (PreToolUse enforcement)"
  homepage "https://github.com/kastra-labs/kastra-edge"
  version "0.2.9" # filled by release.yml on a cli-v* tag
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastrahook-darwin-arm64"
    sha256 "e248b54da7044968b81c888e7a05fc5ae5fc370d42132b9deaff88e8465f63f1"
  else
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastrahook-darwin-amd64"
    sha256 "3660307df111baf34054af0209446e375df6244a3ee8ac5baab84f8d705e8632"
  end

  def install
    bin.install Dir["kastrahook-*"].first => "kastrahook"
  end

  test do
    # kastrahook reads a JSON hook event on stdin and has no --version flag.
    assert_predicate bin/"kastrahook", :executable?
  end
end
