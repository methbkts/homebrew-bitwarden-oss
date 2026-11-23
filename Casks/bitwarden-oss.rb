cask "bitwarden-oss" do
  url_end = on_system_conditional macos: "universal.dmg", linux: "x86_64.AppImage"

  version "2026.11.0"
  sha256 arm:          "25880613506deb2b3df4b1997746b687e9e826d0c6a8df4745429ab55f79b18e",
         intel:        "25880613506deb2b3df4b1997746b687e9e826d0c6a8df4745429ab55f79b18e",
         x86_64_linux: "a3a26a08d74577310d499c739026ebfb60864570d5be18d1aecdf43f4127bad2"

  on_macos do
    depends_on macos: :monterey

    app "Bitwarden.app"

    uninstall quit: [
      "com.bitwarden.desktop",
      "com.bitwarden.desktop.helper",
    ]

    zap trash: [
      "~/Library/Application Scripts/com.bitwarden.desktop.autofill-extension",
      "~/Library/Application Scripts/LTZ2PFU5D6.com.bitwarden.desktop",
      "~/Library/Application Support/Bitwarden",
      "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.bitwarden.desktop.sfl*",
      "~/Library/Caches/com.bitwarden.desktop",
      "~/Library/Caches/com.bitwarden.desktop.ShipIt",
      "~/Library/Containers/com.bitwarden.desktop.autofill-extension",
      "~/Library/Group Containers/LTZ2PFU5D6.com.bitwarden.desktop",
      "~/Library/Logs/Bitwarden",
      "~/Library/Preferences/ByHost/com.bitwarden.desktop.ShipIt.*.plist",
      "~/Library/Preferences/com.bitwarden.desktop.helper.plist",
      "~/Library/Preferences/com.bitwarden.desktop.plist",
      "~/Library/Saved Application State/com.bitwarden.desktop.savedState",
    ]
  end
  on_linux do
    depends_on arch: :x86_64

    app_image "oss-Bitwarden-#{version}-x86_64.AppImage", target: "Bitwarden.AppImage"

    zap trash: [
      "~/.cache/bitwarden-updater",
      "~/.cache/com.bitwarden.desktop",
      "~/.config/autostart/bitwarden.desktop",
      "~/.config/Bitwarden",
    ]
  end

  url "https://github.com/bitwarden/clients/releases/download/desktop-v#{version}/oss-Bitwarden-#{version}-#{url_end}"
  name "Bitwarden OSS"
  desc "Open source (GPLv3) desktop password manager with encrypted vault"
  homepage "https://github.com/bitwarden/clients"

  livecheck do
    url "https://github.com/bitwarden/clients"
    regex(/^desktop-v(\d+(?:\.\d+)+)$/i)
  end

  conflicts_with cask: "bitwarden"
end
