cask "kodisle" do
  version "0.1.1"
  sha256 "02574f6f3904b39bf9cf0af2d7d256fc3a91477c7c37c81e89463c6d7c3ad473"

  url "https://github.com/pablorod1/kodisle/releases/download/v#{version}/Kodisle.zip"
  name "Kodisle"
  desc "Dev environment at a glance: dynamic island, dock and menu bar widgets"
  homepage "https://github.com/pablorod1/kodisle"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :tahoe"

  app "Kodisle.app"

  # Not notarized yet (no Apple Developer ID): drop the quarantine flag so Gatekeeper
  # doesn't block the first launch. The download itself is verified by sha256 above.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Kodisle.app"]
  end

  # Quitting Kodisle restores the macOS Dock if the Kodisle dock was enabled.
  uninstall quit: "io.github.pablorod1.kodisle"

  zap trash: [
    "~/.kodisle",
    "~/Library/Preferences/io.github.pablorod1.kodisle.plist",
  ]
end
