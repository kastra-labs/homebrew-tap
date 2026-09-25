class Kastra < Formula
  desc "Kastra control-plane CLI — manage policies, evidence, agents, and CI from your terminal"
  homepage "https://github.com/kastra-labs/kastra-edge"
  version "0.13.8" # filled by release.yml on a cli-v* tag
  license :cannot_represent

  # `kastra` is the universal, cross-platform control-plane CLI (distinct from
  # kastra-edge, the macOS endpoint-enforcement agent). Operators run it on
  # macOS; CI runs the Linux build. Published to the PUBLIC kastra-edge-releases
  # repo (the kastra-edge source is private). version + sha256 are filled by
  # .github/workflows/release.yml.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-darwin-arm64.tar.gz"
      sha256 "64fe40abe37104a05847c4d9e2f2aed51af985e90dc278d7ae4aca5992038ada"
    else
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-darwin-amd64.tar.gz"
      sha256 "8f3d0103bafd6ba30b70f4039f8bf3eb20441e5696e9f4d015cc797c725edd2e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-linux-arm64.tar.gz"
      sha256 "8e04780c2ca171cdbab97242c1da64a864a876ca3750d7e3cba874fe3affdd30"
    else
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-linux-amd64.tar.gz"
      sha256 "1add5c598e098f1f7aa26720f49c160b3cd920c453296d39261c8b2a83552679"
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
