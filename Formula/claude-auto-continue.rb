class ClaudeAutoContinue < Formula
  include Language::Python::Virtualenv

  desc "Auto-click Continue in Claude desktop app, browser, and CLI"
  homepage "https://github.com/PrivateVictories-Main/claude-auto-continue-macos"
  url "https://github.com/PrivateVictories-Main/claude-auto-continue-macos/archive/v0.7.0.tar.gz"
  sha256 "f482919f5ad0115d3afe76286ac5158dd17f10c8f09ec33a269d9838e7ebf034"
  license "MIT"

  depends_on :macos
  depends_on "python@3.12"

  def install
    venv = virtualenv_create(libexec, "python3.12")
    # Install pyobjc dependencies explicitly — pip_install_and_link
    # alone sometimes misses native extensions in the Homebrew sandbox.
    system libexec/"bin/pip", "install",
           "pyobjc-core>=10.0",
           "pyobjc-framework-ApplicationServices>=10.0",
           "pyobjc-framework-Cocoa>=10.0",
           "rich>=13.0"
    venv.pip_install_and_link buildpath
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
