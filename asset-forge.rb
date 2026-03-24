class AssetForge < Formula
  desc "The complete asset toolkit for developers"
  homepage "https://github.com/Ricka7x/asset-forge"
  url "https://registry.npmjs.org/@ricka7x/asset-forge/-/asset-forge-0.3.3.tgz"
  sha256 "9fd9a348e0f49a7bdbc6498320d59b6101dae0d100835898af31fae19bc96d92"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args(prefix: libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "the complete asset toolkit", shell_output("#{bin}/asset-forge --help")
  end
end
