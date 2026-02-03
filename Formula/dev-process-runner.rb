class DevProcessRunner < Formula
  desc "Terminal UI for managing multiple development services"
  homepage "https://github.com/tx2z/dpr"
  license "MIT"
  version "1.2.0"

  on_macos do
    on_arm do
      url "https://github.com/tx2z/dpr/releases/download/v1.2.0/dpr-macos-arm64"
      sha256 "77ddd998426c45069dbb0d8c2cb4d453359463fe230d8406d53edd088fe923ca"
    end
    on_intel do
      url "https://github.com/tx2z/dpr/releases/download/v1.2.0/dpr-macos-x64"
      sha256 "8bf7e685ce6edb541c6a7457b022401d23c774c3165f543a249e02dfb424a33e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tx2z/dpr/releases/download/v1.2.0/dpr-linux-arm64"
      sha256 "b0f690cb97df3359bc0aab9cf7ba35eb1804a074d3b33d687a39e6e717a44fb5"
    end
    on_intel do
      url "https://github.com/tx2z/dpr/releases/download/v1.2.0/dpr-linux-x64"
      sha256 "4adb7cd2fab079e6eacb2b868b1303e086d00bf05fcb10b40f94508e2a6543c5"
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
