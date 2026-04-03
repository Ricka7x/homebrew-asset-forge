class AssetForge < Formula
  desc "The complete asset toolkit for developers"
  homepage "https://github.com/Ricka7x/asset-forge"
  url "https://registry.npmjs.org/@ricka7x/asset-forge/-/asset-forge-0.3.4.tgz"
  sha256 "f1e31359bcbdaf58fb23fc55c34b5be7b08a7c22e6d3c21bf30a805128c0f0ad"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args(prefix: libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "the complete asset toolkit", shell_output("#{bin}/asset-forge --help")
  end
end
