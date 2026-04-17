class ClaudeAutoContinue < Formula
  include Language::Python::Virtualenv

  desc "Auto-click Continue in Claude desktop app, browser, and CLI"
  homepage "https://github.com/PrivateVictories-Main/claude-auto-continue-macos"
  url "https://github.com/PrivateVictories-Main/claude-auto-continue-macos/archive/v0.7.0.tar.gz"
  sha256 "f482919f5ad0115d3afe76286ac5158dd17f10c8f09ec33a269d9838e7ebf034"
  license "MIT"

  depends_on :macos
  depends_on "python@3.12"

  resource "pyobjc-core" do
    url "https://files.pythonhosted.org/packages/64/5a/6b15e499de73050f4a2c88fff664ae154307d25dc04da8fb38998a428358/pyobjc_core-12.1-cp312-cp312-macosx_10_13_universal2.whl"
    sha256 "818bcc6723561f207e5b5453efe9703f34bc8781d11ce9b8be286bb415eb4962"
  end

  resource "pyobjc-framework-Cocoa" do
    url "https://files.pythonhosted.org/packages/95/bf/ee4f27ec3920d5c6fc63c63e797c5b2cc4e20fe439217085d01ea5b63856/pyobjc_framework_cocoa-12.1-cp312-cp312-macosx_10_13_universal2.whl"
    sha256 "547c182837214b7ec4796dac5aee3aa25abc665757b75d7f44f83c994bcb0858"
  end

  resource "pyobjc-framework-CoreText" do
    url "https://files.pythonhosted.org/packages/cd/0f/ddf45bf0e3ba4fbdc7772de4728fd97ffc34a0b5a15e1ab1115b202fe4ae/pyobjc_framework_coretext-12.1-cp312-cp312-macosx_10_13_universal2.whl"
    sha256 "d246fa654bdbf43bae3969887d58f0b336c29b795ad55a54eb76397d0e62b93c"
  end

  resource "pyobjc-framework-Quartz" do
    url "https://files.pythonhosted.org/packages/e9/9b/780f057e5962f690f23fdff1083a4cfda5a96d5b4d3bb49505cac4f624f2/pyobjc_framework_quartz-12.1-cp312-cp312-macosx_10_13_universal2.whl"
    sha256 "7730cdce46c7e985535b5a42c31381af4aa6556e5642dc55b5e6597595e57a16"
  end

  resource "pyobjc-framework-ApplicationServices" do
    url "https://files.pythonhosted.org/packages/37/a7/55fa88def5c02732c4b747606ff1cbce6e1f890734bbd00f5596b21eaa02/pyobjc_framework_applicationservices-12.1-cp312-cp312-macosx_10_13_universal2.whl"
    sha256 "c8f6e2fb3b3e9214ab4864ef04eee18f592b46a986c86ea0113448b310520532"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/c0/8f/0722ca900cc807c13a6a0c696dacf35430f72e0ec571c4275d2371fca3e9/rich-15.0.0.tar.gz"
    sha256 "edd07a4824c6b40189fb7ac9bc4c52536e9780fbbfbddf6f1e2502c31b068c36"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/5b/f5/4ec618ed16cc4f8fb3b701563655a69816155e79e24a17b651541804721d/markdown_it_py-4.0.0.tar.gz"
    sha256 "cb0a2b4aa34f932c007117b194e945bd74e0ec24133ceb5bac59009cda1cb9f3"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/c3/b2/bc9c9196916376152d655522fdcebac55e66de6603a76a02bca1b6414f6c/pygments-2.20.0.tar.gz"
    sha256 "6757cd03768053ff99f3039c1a36d6c0aa0b263438fcab17520b30a303a82b5f"
  end

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      Accessibility permission is required for claude-auto-continue to work.

      Quick setup (recommended):
        claude-auto-continue --setup

      Or manually:
        1. Open System Settings → Privacy & Security → Accessibility
        2. Click + and add: #{HOMEBREW_PREFIX}/opt/python@3.12/bin/python3.12
        3. Toggle it ON

      To run as a background service (auto-start on login):
        brew services start claude-auto-continue

      Dashboard: http://127.0.0.1:8787 (when running)
    EOS
  end

  service do
    run [opt_bin/"claude-auto-continue"]
    keep_alive true
    log_path var/"log/claude-auto-continue.log"
    error_log_path var/"log/claude-auto-continue.err.log"
    environment_variables PYTHONUNBUFFERED: "1"
  end

  test do
    assert_match "claude-auto-continue", shell_output("#{bin}/claude-auto-continue --version")
  end
end
