class Kastrahook < Formula
  desc "Kastra policy hook for Claude Code / Codex (PreToolUse enforcement)"
  homepage "https://github.com/kastra-labs/kastra-edge"
  version "0.10.0" # filled by release.yml on a cli-v* tag
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastrahook-darwin-arm64"
    sha256 "c5a8cbb46ce4345f7bfee38c854daa9616151e7d03dad56c0685e217aba22fd2"
  else
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastrahook-darwin-amd64"
    sha256 "a554351b1b8648665258a94eb87e071bf5c4a2205ce482b9d326773a851028ce"
  end

  def install
    bin.install Dir["kastrahook-*"].first => "kastrahook"
  end

  test do
    # kastrahook reads a JSON hook event on stdin and has no --version flag.
    assert_predicate bin/"kastrahook", :executable?
  end
end
