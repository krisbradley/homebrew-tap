class ClaudeSessionFinder < Formula
  desc "Interactive browser for Claude Code sessions"
  homepage "https://github.com/krisbradley/claude-session-finder"
  url "https://github.com/krisbradley/claude-session-finder/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "f00c390179cc3890153a8ccae7ac9173687a4fc3092193aad9d7eef5c81914f7"
  license "MIT"

  depends_on "fzf"
  depends_on "python3"

  def install
    bin.install "csf"

    # Install helper scripts
    (libexec/"scripts").install Dir["scripts/*"]

    ["csf-preview", "csf-search", "csf-delete", "csf-export"].each do |script|
      (bin/script).write <<~SH
        #!/bin/bash
        exec python3 "#{libexec}/scripts/#{script}" "$@"
      SH
      (bin/script).chmod 0755
    end
  end

  test do
    assert_predicate bin/"csf", :exist?
  end
end
