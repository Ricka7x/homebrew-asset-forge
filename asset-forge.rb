class AssetForge < Formula
  desc "The complete asset toolkit for developers"
  homepage "https://github.com/Ricka7x/asset-forge"
  version "0.1.0"

  depends_on "imagemagick"
  depends_on "ffmpeg"

  on_macos do
    on_arm do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.1.0/asset-forge-darwin-arm64"
      sha256 "c9460941d3d01d14805e5448d922ec9203dc822842b2ce422b012c73a94c214a"
    end
    on_intel do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.1.0/asset-forge-darwin-x64"
      sha256 "6788362321b502cad985aa74a1eaae4ca05907d2a466a15cb1b8ebb3ed523c7b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.1.0/asset-forge-linux-x64"
      sha256 "c7d160d1127195059756a0363d7407a670202d70e444ec0ba86d193a68340a2a"
    end
  end

  resource "scripts" do
    url "https://github.com/Ricka7x/asset-forge/releases/download/v0.1.0/scripts.tar.gz"
    sha256 "2c788a0c6ad58b93e987150f6c7d6fb4c97cebad540085ec98db11cc77d2517d"
  end

  def install
    os   = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "x64"
    bin.install "asset-forge-\#{os}-\#{arch}" => "asset-forge"
    bin.install_symlink "asset-forge" => "forge"

    scripts_dir = libexec/"asset-forge/scripts"
    scripts_dir.mkpath
    resource("scripts").stage { scripts_dir.install Dir["*"] }
  end

  def caveats
    <<~EOS
      Two commands require Python packages (not installed automatically):
        blur-hash:  pip install Pillow blurhash
        duplicates: pip install Pillow
    EOS
  end

  test do
    assert_match "asset-forge", shell_output("#{bin}/asset-forge --help")
  end
end
