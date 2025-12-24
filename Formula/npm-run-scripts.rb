class NpmRunScripts < Formula
  desc "Fast interactive TUI for running npm scripts"
  homepage "https://github.com/tx2z/nrs"
  version "1.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tx2z/nrs/releases/download/v1.0.1/npm-run-scripts-aarch64-apple-darwin.tar.xz"
      sha256 "71610397dae877b5192752b045ecb210054f80d13fd6fcc8aa0e202c97b6456d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tx2z/nrs/releases/download/v1.0.1/npm-run-scripts-x86_64-apple-darwin.tar.xz"
      sha256 "b8986a555ecd5a5b585009c84dddcd04e39902ae982c1ac3ef55f3ab1013a8f8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tx2z/nrs/releases/download/v1.0.1/npm-run-scripts-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d02f3a62f769044008df8e2253c1835d83f7ef81255ceea3faa9395c357eb197"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tx2z/nrs/releases/download/v1.0.1/npm-run-scripts-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0038a5fd4b34b7ba31ea7d4bf6c07ae04dc7b6c573fa956b53f53ed37691c457"
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
