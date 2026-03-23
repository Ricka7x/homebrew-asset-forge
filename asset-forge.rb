class AssetForge < Formula
  desc "The complete asset toolkit for developers"
  homepage "https://github.com/Ricka7x/asset-forge"
  version "0.2.0"

  depends_on "imagemagick"
  depends_on "ffmpeg"

  on_macos do
    on_arm do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.0/asset-forge-darwin-arm64"
      sha256 "ca1e9b93f3bf63f9222ad739fba1bebad40d52d9c5fa590f299b94c49a1e4ab8"
    end
    on_intel do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.0/asset-forge-darwin-x64"
      sha256 "a06a7eedc860919dc5e69d53add7b09b85cc235386848f2ae4065a41f9d0ea71"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.0/asset-forge-linux-x64"
      sha256 "ca82dd8048f3fa2512747235c752daf39df6fbb1965689b22e6ab8676c8a94f6"
    end
  end

  resource "scripts" do
    url "https://github.com/Ricka7x/asset-forge/releases/download/v0.2.0/scripts.tar.gz"
    sha256 "151ae222c71fd760185ad799706e31b93dca75ca3588bb44cd2083fe64b10cc0"
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
