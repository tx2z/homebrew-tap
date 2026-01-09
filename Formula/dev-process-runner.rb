class DevProcessRunner < Formula
  desc "Terminal UI for managing multiple development services"
  homepage "https://github.com/tx2z/dpr"
  license "MIT"
  version "1.1.0"

  on_macos do
    on_arm do
      url "https://github.com/tx2z/dpr/releases/download/v1.1.0/dpr-macos-arm64"
      sha256 "26e37f5ee2e0f54f121772b27296bf99fbe66d469e4e2c78995524cd69cedb63"
    end
    on_intel do
      url "https://github.com/tx2z/dpr/releases/download/v1.1.0/dpr-macos-x64"
      sha256 "5836a96cb36fa8eca0859d196c6c3e1b68ba5f4ebf3a0dc87511b05064ec5781"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tx2z/dpr/releases/download/v1.1.0/dpr-linux-arm64"
      sha256 "e76a6910a325d4ff5f3809301aa5d4ab7bee53d73f8051e1c1bbf190953be182"
    end
    on_intel do
      url "https://github.com/tx2z/dpr/releases/download/v1.1.0/dpr-linux-x64"
      sha256 "3b43330f36d4c9205f17e60ec8deea151d066e55ec579f25e702d8d1d7e670e9"
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
