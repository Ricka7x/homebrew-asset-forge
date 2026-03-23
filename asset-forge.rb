class AssetForge < Formula
  desc "The complete asset toolkit for developers"
  homepage "https://github.com/Ricka7x/asset-forge"
  version "0.2.1"

  depends_on "imagemagick"
  depends_on "ffmpeg"

  on_macos do
    on_arm do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.1/asset-forge-darwin-arm64"
      sha256 "7c91264186662d2d66ae99eb3ed4d168743b713f7a90f54b970653496ff6663b"
    end
    on_intel do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.1/asset-forge-darwin-x64"
      sha256 "4942c492e4cd3a267b8e68114d3d11af58a382f375719a537e64d97e52bf7f39"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.1/asset-forge-linux-x64"
      sha256 "0f1fae006811fabe49b17d95d9fc32f44d4f0e331d0b0c95f611e882d791eb8c"
    end
  end

  resource "scripts" do
    url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.1/scripts.tar.gz"
    sha256 "fbf517b67c68901f52d15fa8cb1daf53e7245eddc8c08e1dd8ceac4b1041b500"
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
