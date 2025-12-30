class DevProcessRunner < Formula
  desc "Terminal UI for managing multiple development services"
  homepage "https://github.com/tx2z/dpr"
  license "MIT"
  version "1.0.5"

  on_macos do
    on_arm do
      url "https://github.com/tx2z/dpr/releases/download/v1.0.5/dpr-macos-arm64"
      sha256 "ccbae5ca12a655c19891e770eb87d5558db8cb5c7cbddebb89aad15cc8f87784"
    end
    on_intel do
      url "https://github.com/tx2z/dpr/releases/download/v1.0.5/dpr-macos-x64"
      sha256 "3b95b7bf470f1709b2d4d58ca0a32bb89e0d55e42295df30df478608c9ea60e9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tx2z/dpr/releases/download/v1.0.5/dpr-linux-arm64"
      sha256 "7c76d27487aa0bf699f579f18f356a431b0d3340a46ad7ad43a08beb4ca13df7"
    end
    on_intel do
      url "https://github.com/tx2z/dpr/releases/download/v1.0.5/dpr-linux-x64"
      sha256 "500d373df0a3b0ac96fdbe50533b03736666ec7843b155f1f941b86dd3899dd8"
    end
  end

  def install
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "dpr-macos-arm64" : "dpr-macos-x64"
    else
      Hardware::CPU.arm? ? "dpr-linux-arm64" : "dpr-linux-x64"
    end
    bin.install binary_name => "dpr"
  end

  test do
    assert_match "dpr", shell_output("#{bin}/dpr --help 2>&1", 1)
  end
end
