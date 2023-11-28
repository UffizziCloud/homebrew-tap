class Uffizzi < Formula
  desc "Self-serve developer platforms in minutes, not months with k8s virtual clusters"
  homepage "https://uffizzi.com"
  url "https://github.com/UffizziCloud/uffizzi_cli/archive/refs/tags/v2.3.4.tar.gz"
  sha256 "170849b4054e45b6a4c0fd8343f05e55817c8f10b6190d7f0d3edf1ae994629e"
  license "Apache-2.0"

  depends_on "ruby@3.0"
  depends_on "skaffold"
  depends_on "helm@3"

  resource "activesupport" do
    url "https://rubygems.org/gems/activesupport-6.1.4.1.gem"
    sha256 "44b781877c2189aa15ca5451e2d310dcedfd16c01df1106f68a91b82990cfda5"
  end

  resource "awesome_print" do
    url "https://rubygems.org/gems/awesome_print-1.9.2.gem"
    sha256 "e99b32b704acff16d768b3468680793ced40bfdc4537eb07e06a4be11133786e"
  end

  resource "faker" do
    url "https://rubygems.org/gems/faker-3.2.2.gem"
    sha256 "1eca58d4611fcc07e1b2b89c6e394a9d2ff780e943752f5ea2dd60e0cc3c84c5"
  end

  resource "launchy" do
    url "https://rubygems.org/gems/launchy-2.5.2.gem"
    sha256 "8aa0441655aec5514008e1d04892c2de3ba57bd337afb984568da091121a241b"
  end

  resource "minitar" do
    url "https://rubygems.org/gems/minitar-0.9.gem"
    sha256 "23c0bebead35dbfe9e24088dc436c8a233d03f51d365a686b9a11dd30dc2d588"
  end

  resource "securerandom" do
    url "https://rubygems.org/gems/securerandom-0.3.0.gem"
    sha256 "3764e51c62393f0e5378637362836db3cf0c3223e2ae134eadcb347999105dda"
  end

  resource "sentry-ruby" do
    url "https://rubygems.org/gems/sentry-ruby-5.14.0.gem"
    sha256 "0940fb8b5de834aa735e29ae674332be4a5a62c303669c4d98a817ae6adac280"
  end

  resource "thor" do
    url "https://rubygems.org/gems/thor-1.3.0.gem"
    sha256 "1adc7f9e5b3655a68c71393fee8bd0ad088d14ee8e83a0b73726f23cbb3ca7c3"
  end

  resource "tty-prompt" do
    url "https://rubygems.org/gems/tty-prompt-0.23.1.gem"
    sha256 "fcdbce905238993f27eecfdf67597a636bc839d92192f6a0eef22b8166449ec8"
  end

  resource "tty-spinner" do
    url "https://rubygems.org/gems/tty-spinner-0.9.3.gem"
    sha256 "0e036f047b4ffb61f2aa45f5a770ec00b4d04130531558a94bfc5b192b570542"
  end

  resource "uffizzi-cli" do
    url "https://rubygems.org/gems/uffizzi-cli-2.3.4.gem"
    sha256 "b0d081dc37cb08eafbc18dee3056eaab099401d74335a8d0a4d0e06a057e9a70"
  end

  def install
    ENV["GEM_HOME"] = libexec
    ENV["GEM_PATH"] = libexec

    resources.each do |r|
      r.fetch
      system "gem", "install", r.cached_download, "--no-document", "--install-dir", libexec
    end

    bin.install Dir["#{libexec}/bin/*"]

    bin.env_script_all_files(libexec, GEM_HOME: ENV["GEM_HOME"], GEM_PATH: ENV["GEM_PATH"])
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/uffizzi version")
    server_url = "https://example.com"
    system bin/"uffizzi config set server #{server_url}"
    assert_match server_url, shell_output("#{bin}/uffizzi config get-value server")
  end
end
