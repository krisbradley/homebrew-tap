class ClaudeSessionFinder < Formula
  desc "Interactive browser for Claude Code sessions"
  homepage "https://github.com/krisbradley/claude-session-finder"
  url "https://github.com/krisbradley/claude-session-finder/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "c36421a9e8c1790da1fe329152f0b87148b795bd405a712f81992b965724df8a"
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
