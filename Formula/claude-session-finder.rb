class ClaudeSessionFinder < Formula
  desc "Interactive browser for Claude Code sessions"
  homepage "https://github.com/kristopherbradley/claude-session-finder"
  url "https://github.com/kristopherbradley/claude-session-finder/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "PLACEHOLDER" # Run: shasum -a 256 <downloaded-tarball> after creating the release
  license "MIT"

  depends_on "fzf"
  depends_on "python3"

  def install
    bin.install "csf"

    # Install helper scripts
    (libexec/"scripts").install Dir["scripts/*"]

    # Set up Python venv with sumy + numpy for csf-summarize
    venv_dir = libexec/"csf-venv"
    system "python3", "-m", "venv", venv_dir
    system "#{venv_dir}/bin/pip", "install", "--quiet", "sumy", "numpy"

    # Write wrappers for helper scripts that need the venv
    ["csf-preview", "csf-search", "csf-delete", "csf-export"].each do |script|
      (bin/script).write <<~SH
        #!/bin/bash
        exec python3 "#{libexec}/scripts/#{script}" "$@"
      SH
      (bin/script).chmod 0755
    end

    (bin/"csf-summarize").write <<~SH
      #!/bin/bash
      exec "#{venv_dir}/bin/python3" "#{libexec}/scripts/csf-summarize" "$@"
    SH
    (bin/"csf-summarize").chmod 0755
  end

  def post_install
    # Set up Stop hook in Claude Code settings
    settings = Pathname.new(ENV["HOME"]) / ".claude/settings.json"
    if settings.exist?
      ohai "To enable auto-summarize after each session, add this to #{settings}:"
      ohai '  "Stop": [{"matcher":"","hooks":[{"type":"command","command":"csf-summarize"}]}]'
    end
  end

  test do
    assert_predicate bin/"csf", :exist?
    assert_predicate bin/"csf-summarize", :exist?
  end
end
