class Kastra < Formula
  desc "Kastra control-plane CLI — manage policies, evidence, agents, and CI from your terminal"
  homepage "https://github.com/kastra-labs/kastra-edge"
  version "0.5.5" # filled by release.yml on a cli-v* tag
  license :cannot_represent

  # `kastra` is the universal, cross-platform control-plane CLI (distinct from
  # kastra-edge, the macOS endpoint-enforcement agent). Operators run it on
  # macOS; CI runs the Linux build. Published to the PUBLIC kastra-edge-releases
  # repo (the kastra-edge source is private). version + sha256 are filled by
  # .github/workflows/release.yml.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-darwin-arm64.tar.gz"
      sha256 "8f381650a2a4ef4ec4a1ac38e976cc1c5413392f41b3cd6e136d93e80f9cc5e2"
    else
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-darwin-amd64.tar.gz"
      sha256 "070ec287d6899537e196b2134b5ab6bbbf104e481a78dd47c9456763ef79a2ec"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-linux-arm64.tar.gz"
      sha256 "a283f5319d224c929df480e4668b742dd9a85959b3f19d5acdd163b6375d6ae8"
    else
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-linux-amd64.tar.gz"
      sha256 "ef67a74733952fcb4c7784e6c33203cb4a8badf1e88b5b46104586d329547702"
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
