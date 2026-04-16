class AssetForge < Formula
  desc "The complete asset toolkit for developers"
  homepage "https://github.com/Ricka7x/asset-forge"
  url "https://registry.npmjs.org/@ricka7x/asset-forge/-/asset-forge-0.3.5.tgz"
  sha256 "5ee9f67dc6f4fc9f4f29fb32b9721ae39644e74330541c41ee0b039ac29c8ec9"

  depends_on "node"
  depends_on "ffmpeg"

  def install
    system "npm", "install", *std_npm_args(prefix: libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "the complete asset toolkit", shell_output("#{bin}/asset-forge --help")
  end
end
