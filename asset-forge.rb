class AssetForge < Formula
  desc "The complete asset toolkit for developers"
  homepage "https://github.com/Ricka7x/asset-forge"
  version "0.2.3"

  depends_on "imagemagick"
  depends_on "ffmpeg"

  on_macos do
    on_arm do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.3/asset-forge-darwin-arm64"
      sha256 "9bb488c8cbb50c6f2da8823aa278041cb7d9a01700d0ed075077e0c409d8805e"
    end
    on_intel do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.3/asset-forge-darwin-x64"
      sha256 "cc60a5b1715b26ca94b948f71a0fd22c02b51a5e01fd8216c11fe4610ea12b95"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.3/asset-forge-linux-x64"
      sha256 "dded55fcfcb58f2e04d5b828a09dcce69922d36911d9646a347489013855e4fa"
    end
  end

  resource "scripts" do
    url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.3/scripts.tar.gz"
    sha256 "0308474d3b327f996b6725955687d8a5b478774cc69bcbf4bc07a586c57e246c"
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
