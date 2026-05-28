cask "clawpypaste" do
  version "0.2.13"
  sha256 "a37605ea90e586e47b87be50c037777c30ae02998e563b85d1bb0a057aefc11b"

  url "https://github.com/krisbradley/clawpypaste/releases/download/v#{version}/clawpypaste.zip"
  name "clawpypaste"
  desc "Menu bar app for grabbing code/text blocks from your active Claude Code session"
  homepage "https://github.com/krisbradley/clawpypaste"

  depends_on macos: ">= :ventura"

  app "clawpypaste.app"

  binary "#{appdir}/clawpypaste.app/Contents/MacOS/clawpypaste"

  postflight do
    # Strip the quarantine flag so the app opens without a Gatekeeper prompt
    # (it's already notarized, but downloads via curl/brew still carry the
    # quarantine xattr until first launch).
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/clawpypaste.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/clawpypaste",
    "~/Library/Caches/com.kristopherbradley.clawpypaste",
    "~/Library/Preferences/com.kristopherbradley.clawpypaste.plist",
  ]
end
