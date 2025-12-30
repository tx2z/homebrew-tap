class DevProcessRunner < Formula
  desc "Terminal UI for managing multiple development services"
  homepage "https://github.com/tx2z/dpr"
  license "MIT"
  version "1.0.3"

  on_macos do
    on_arm do
      url "https://github.com/tx2z/dpr/releases/download/v1.0.3/dpr-macos-arm64"
      sha256 "f39879d5690fb6c3add5cf9abdf118942b8a6d5a6c7c3f62ed294e279660e1c2"
    end
    on_intel do
      url "https://github.com/tx2z/dpr/releases/download/v1.0.3/dpr-macos-x64"
      sha256 "d3591763a4940991e529d3ecf08b5c2ed177d2bef480ee13a284a5cb1408f253"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tx2z/dpr/releases/download/v1.0.3/dpr-linux-arm64"
      sha256 "d2a0482cb9b4261e952c2af260d25d41dae70621fff7298579b2a701f50ca903"
    end
    on_intel do
      url "https://github.com/tx2z/dpr/releases/download/v1.0.3/dpr-linux-x64"
      sha256 "b3dc995a437f804d6a330e85252792ebf851d51a84f60e70325151359e27d611"
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
