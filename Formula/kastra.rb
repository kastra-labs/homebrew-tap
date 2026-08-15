class Kastra < Formula
  desc "Kastra control-plane CLI — manage policies, evidence, agents, and CI from your terminal"
  homepage "https://github.com/kastra-labs/kastra-edge"
  version "0.9.0" # filled by release.yml on a cli-v* tag
  license :cannot_represent

  # `kastra` is the universal, cross-platform control-plane CLI (distinct from
  # kastra-edge, the macOS endpoint-enforcement agent). Operators run it on
  # macOS; CI runs the Linux build. Published to the PUBLIC kastra-edge-releases
  # repo (the kastra-edge source is private). version + sha256 are filled by
  # .github/workflows/release.yml.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-darwin-arm64.tar.gz"
      sha256 "79318fb3d1458ace0961c1e5892cf32a0aa39d043e8a725935adf8e13756fb09"
    else
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-darwin-amd64.tar.gz"
      sha256 "0a23f85a51db1cf452328dcf91ce4f8f33620c3d1795c540ce4f69ba06c43ec3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-linux-arm64.tar.gz"
      sha256 "f4e7e256de5b0dcce06d6c7f9db69e8576578d0234bcfb606db2d56112f57137"
    else
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-linux-amd64.tar.gz"
      sha256 "39b1d7b0bb622b8709495ace56517f31946774eb321b9d509f04f9afdf84285a"
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
