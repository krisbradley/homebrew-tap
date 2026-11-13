cask "clawpypaste" do
  version "0.4.12"
  sha256 "fb91beb04a37b73c1462c57dd51cde3485d7e5f0949d1a3ce501f9399724daf7"

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
