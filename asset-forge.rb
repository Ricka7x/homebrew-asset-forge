class AssetForge < Formula
  desc "The complete asset toolkit for developers"
  homepage "https://github.com/Ricka7x/asset-forge"
  url "https://registry.npmjs.org/@ricka7x/asset-forge/-/asset-forge-0.3.2.tgz"
  sha256 "ef9ce7cdc759c862bd743596241a79cb8f89e844b87e0da44dd60e493ddb8552"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args(prefix: libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "the complete asset toolkit", shell_output("#{bin}/asset-forge --help")
  end
end
