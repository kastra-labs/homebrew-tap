class Kastrahook < Formula
  desc "Kastra policy hook for Claude Code / Codex (PreToolUse enforcement)"
  homepage "https://github.com/kastra-labs/kastra-edge"
  version "0.13.9" # filled by release.yml on a cli-v* tag
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastrahook-darwin-arm64"
    sha256 "e8028597107dfc61fa98d200666c731ead784dcb33d4e73846584bc25b3675b9"
  else
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastrahook-darwin-amd64"
    sha256 "fff2f0caa09ba9bcc98938e9cc0b9d25e3a9f2c7b5789484984f2785efbe8d4a"
  end

  def install
    bin.install Dir["kastrahook-*"].first => "kastrahook"
  end

  test do
    # kastrahook reads a JSON hook event on stdin and has no --version flag.
    assert_predicate bin/"kastrahook", :executable?
  end
end
