class Engenos < Formula
  desc "EnGen OS — EnGenAI local-deployment app (console + Cortex + autonomy runtime)"
  homepage "https://github.com/EnGen-AI/engenos"
  url "https://github.com/EnGen-AI/homebrew-engenos/releases/download/v0.1.144/engenos-0.1.144.tar.gz"
  sha256 "c9a29ae5c38cb19073f3f1176c31e0c5c249fa4aad741ffb299c079adab69c59"
  version "0.1.144"

  depends_on "python@3.12"

  def install
    # The release tarball expands to engenos/… (the curated product tree).
    libexec.install Dir["*"]
    (bin/"engenos").write <<~SH
      #!/bin/bash
      exec "#{libexec}/engenos/local-cortex/console/scripts/engenos" "$@"
    SH
    chmod 0755, bin/"engenos"
  end

  def caveats
    <<~EOS
      EnGen OS is installed. To set it up:
        engenos install      # bootstrap Cortex + app-DB (Docker) + the native console
        engenos start

      Requires Docker (for the Cortex stack) + one provider API key (in Settings),
      and a valid ENGENOS_LICENSE_KEY at runtime.

      Upgrade later (non-disruptive — Cortex keeps running):
        brew update && brew upgrade engenos      # or:  engenos upgrade
    EOS
  end

  test do
    assert_match "0.1.144", shell_output("#{bin}/engenos version")
  end
end
