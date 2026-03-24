class AssetForge < Formula
  desc "The complete asset toolkit for developers"
  homepage "https://github.com/Ricka7x/asset-forge"
  version "0.2.4"

  depends_on "imagemagick"
  depends_on "ffmpeg"

  on_macos do
    on_arm do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.4/asset-forge-darwin-arm64"
      sha256 "266c12b3180ecce0fd39cef5cd6343e205471ade435f989a686e9f274ef2b4a0"
    end
    on_intel do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.4/asset-forge-darwin-x64"
      sha256 "3ae847fdf6df31ac27231fedcfa09ee2ee01c65133b858c90943ec36d0af9179"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.4/asset-forge-linux-x64"
      sha256 "d17747cc15d1583797f235e5b22b5755ea330379855c02925a2ee8628d6a2969"
    end
  end

  resource "scripts" do
    url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.4/scripts.tar.gz"
    sha256 "ad5668cbd054adbc38e9af872d86d6c351fffb097bc8c4fb7306acf3f4583943"
  end

  def install
    os   = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "x64"
    bin.install "asset-forge-#{os}-#{arch}" => "asset-forge"
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
