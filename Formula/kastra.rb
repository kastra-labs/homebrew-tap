class Kastra < Formula
  desc "Kastra control-plane CLI — manage policies, evidence, agents, and CI from your terminal"
  homepage "https://github.com/kastra-labs/kastra-edge"
  version "0.5.3" # filled by release.yml on a cli-v* tag
  license :cannot_represent

  # `kastra` is the universal, cross-platform control-plane CLI (distinct from
  # kastra-edge, the macOS endpoint-enforcement agent). Operators run it on
  # macOS; CI runs the Linux build. Published to the PUBLIC kastra-edge-releases
  # repo (the kastra-edge source is private). version + sha256 are filled by
  # .github/workflows/release.yml.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-darwin-arm64.tar.gz"
      sha256 "9f59213ae019b9086fa31f4161c744d30ee2df621187ebc2250707bd33d184e5"
    else
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-darwin-amd64.tar.gz"
      sha256 "26a00c11ceefbe2d2e527e3223b12f90c1f3102cbf99ade56ac02a97f31aebb3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-linux-arm64.tar.gz"
      sha256 "572a7af0dbb0f0881828d71fb7c76b53ee1d8649159cf728aca82e2749060f98"
    else
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-linux-amd64.tar.gz"
      sha256 "2d00a0efc6ecbf52a968ef0758c8244b1b99acc6d4f0c43d17643e8a2bd18e9c"
    end
  end

  def install
    bin.install "kastra"
  end

  def caveats
    <<~EOS
      The Kastra control-plane CLI is installed. Next steps:
        kastra auth login            # authorize as an operator in your browser
        kastra policy list           # inspect your governance policies
        kastra policy apply ./policy.kastra   # publish policy-as-code

      For CI, mint a non-interactive token and set $KASTRA_TOKEN:
        kastra auth create-ci-token --name ci --role admin

      Note: macOS binaries are not yet Apple-notarized. If Gatekeeper blocks it:
        xattr -d com.apple.quarantine "$(brew --prefix)/bin/kastra"
    EOS
  end

  test do
    assert_predicate bin/"kastra", :executable?
    assert_match "operator CLI", shell_output("#{bin}/kastra --help")
  end
end
