class Kastrahook < Formula
  desc "Kastra policy hook for Claude Code / Codex (PreToolUse enforcement)"
  homepage "https://github.com/kastra-labs/kastra-edge"
  version "0.2.14" # filled by release.yml on a cli-v* tag
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastrahook-darwin-arm64"
    sha256 "219656bb9ad1e0468a515d44ef34c974c18439b27cb845dbdd411b4697ab5e37"
  else
    url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastrahook-darwin-amd64"
    sha256 "e7d97f9554bc458941b85770db9f46b37b84bbb055974856fa221f518b23d17d"
  end

  def install
    bin.install Dir["kastrahook-*"].first => "kastrahook"
  end

  test do
    # kastrahook reads a JSON hook event on stdin and has no --version flag.
    assert_predicate bin/"kastrahook", :executable?
  end
end
