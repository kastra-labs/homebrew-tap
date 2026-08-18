class Kastra < Formula
  desc "Kastra control-plane CLI — manage policies, evidence, agents, and CI from your terminal"
  homepage "https://github.com/kastra-labs/kastra-edge"
  version "0.10.0" # filled by release.yml on a cli-v* tag
  license :cannot_represent

  # `kastra` is the universal, cross-platform control-plane CLI (distinct from
  # kastra-edge, the macOS endpoint-enforcement agent). Operators run it on
  # macOS; CI runs the Linux build. Published to the PUBLIC kastra-edge-releases
  # repo (the kastra-edge source is private). version + sha256 are filled by
  # .github/workflows/release.yml.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-darwin-arm64.tar.gz"
      sha256 "a0efa8566945083e34f2f9c7b000444710b173f44bf2b5353692b08b79fa3ab9"
    else
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-darwin-amd64.tar.gz"
      sha256 "0d7c8be439b1d153381a84b715f5f760e76e70e3837b8c388c046ef170496baa"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-linux-arm64.tar.gz"
      sha256 "72f357ba99852bff7b91c82edd860c9d1028a1f29c452d1022d0408607cb2f3b"
    else
      url "https://github.com/kastra-labs/kastra-edge-releases/releases/download/cli-v#{version}/kastra-linux-amd64.tar.gz"
      sha256 "b75eef944ae1ef27d69abb51608cfc4803c5bbe396f10698e38c36a50539f087"
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
