class ClaudeSessions < Formula
  desc "Interactive browser for Claude Code sessions"
  homepage "https://github.com/kristopherbradley/claude-session-finder"
  url "https://github.com/kristopherbradley/claude-session-finder/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "PLACEHOLDER" # Run: shasum -a 256 <downloaded-tarball> after creating the release
  license "MIT"

  def install
    bin.install "claude-sessions"
  end

  test do
    assert_predicate bin/"claude-sessions", :exist?
  end
end
