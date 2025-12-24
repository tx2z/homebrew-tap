class NpmRunScripts < Formula
  desc "Fast interactive TUI for running npm scripts"
  homepage "https://github.com/tx2z/nrs"
  version "1.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tx2z/nrs/releases/download/v1.0.2/npm-run-scripts-aarch64-apple-darwin.tar.xz"
      sha256 "16b49145e1f0bee8ea18d7e872798049b4d4917e82f92a7aa6510cf23673fa42"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tx2z/nrs/releases/download/v1.0.2/npm-run-scripts-x86_64-apple-darwin.tar.xz"
      sha256 "b4bacf75116e91dbfa4dd2bededb476758711fb8d22a2b8ddc1559956ed58268"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tx2z/nrs/releases/download/v1.0.2/npm-run-scripts-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5d6473e0d1f7c5e9e1fcd586f61552a363adf59fc574733a04fdc4a92c8dff6c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tx2z/nrs/releases/download/v1.0.2/npm-run-scripts-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "04a6c4b7026fb59dd326c317ce585b1f17c2b1db6c6bc5db6a6224dead98ea72"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "nrs" if OS.mac? && Hardware::CPU.arm?
    bin.install "nrs" if OS.mac? && Hardware::CPU.intel?
    bin.install "nrs" if OS.linux? && Hardware::CPU.arm?
    bin.install "nrs" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
