class AssetForge < Formula
  desc "The complete asset toolkit for developers"
  homepage "https://github.com/Ricka7x/asset-forge"
  version "0.2.2"

  depends_on "imagemagick"
  depends_on "ffmpeg"

  on_macos do
    on_arm do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.2/asset-forge-darwin-arm64"
      sha256 "ccb0c286a524a9bbd5552d3cb076e723c2ee0ee7284cb6578ddca16d4c7b633b"
    end
    on_intel do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.2/asset-forge-darwin-x64"
      sha256 "5038b77b97bdf8a9ec11f6d9e189511aeea48aa04f4909063ed2f4c9b33f7bc2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.2/asset-forge-linux-x64"
      sha256 "aec3e5ff1a38276dc9d8ea1f15f9d47314725ba79c985ca3ab6b87480db5bef2"
    end
  end

  resource "scripts" do
    url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.2/scripts.tar.gz"
    sha256 "aae1a9ff8595b98573eeadcf2a896ec8f2dbf6b82ec5164e52810bbff0fb7bc0"
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
