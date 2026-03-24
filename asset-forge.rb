class AssetForge < Formula
  desc "The complete asset toolkit for developers"
  homepage "https://github.com/Ricka7x/asset-forge"
  version "0.2.5"

  depends_on "imagemagick"
  depends_on "ffmpeg"

  on_macos do
    on_arm do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.5/asset-forge-darwin-arm64"
      sha256 "b520cdf7b9f7c66af69be97ca97f8b871e3c8e94214890e06e09bcfd0da5f89b"
    end
    on_intel do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.5/asset-forge-darwin-x64"
      sha256 "76ad8ab72194c7603344d80347088cc555336aadd7b57af2a0d92f18f81838e4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.5/asset-forge-linux-x64"
      sha256 "f643fc75d6c8b003fa5eece694b9bca55dc7e467dcecbe265f7acb8ba7302446"
    end
  end

  resource "scripts" do
    url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.5/scripts.tar.gz"
    sha256 "4f3edca42026b1f733d08fd485f9d561b454abb71b2a3d4adb890cf0df5aa8c7"
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
