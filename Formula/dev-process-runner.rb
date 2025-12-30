class DevProcessRunner < Formula
  desc "Terminal UI for managing multiple development services"
  homepage "https://github.com/tx2z/dpr"
  license "MIT"
  version "1.0.4"

  on_macos do
    on_arm do
      url "https://github.com/tx2z/dpr/releases/download/v1.0.4/dpr-macos-arm64"
      sha256 "37d84cb3f8e3a583573d79ee1b07cfdb1867805fa3764d09852cf1b82bfc41a8"
    end
    on_intel do
      url "https://github.com/tx2z/dpr/releases/download/v1.0.4/dpr-macos-x64"
      sha256 "225e93eb15b0254dbd80fd1282095b7c9566ee270ad9b5980a294497ca17fbf8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tx2z/dpr/releases/download/v1.0.4/dpr-linux-arm64"
      sha256 "f380ab4bb76e0a893d985008396c4f14bee1d6d5f6e8a87fc32842a39a988b4d"
    end
    on_intel do
      url "https://github.com/tx2z/dpr/releases/download/v1.0.4/dpr-linux-x64"
      sha256 "7d8fb8b173fb575f9dae7ecbe1a419f115fbf29ccf47512598a4a032ebfba30e"
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
