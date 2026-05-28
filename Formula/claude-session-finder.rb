class ClaudeSessionFinder < Formula
  desc "Interactive browser for Claude Code sessions"
  homepage "https://github.com/krisbradley/claude-session-finder"
  url "https://github.com/krisbradley/claude-session-finder/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "fcc8f4dd3fd3f9e8496c7c55dd04621d80b3d29e991f048961ccbbfba479eba9"
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
