cask "propresenter" do
  on_big_sur :or_older do
    version "7.14.1,118358275"
    sha256 "266bfffd2753f460f9a22e834aed502c73bed2bf51747238fe4831c9048993db"

    livecheck do
      url "https://api.renewedvision.com/v1/pro/upgrade?platform=macos&osVersion=11.0&appVersion=0&buildNumber=0&includeNotes=0"
      regex(%r{/ProPresenter[._-]v?(\d+(?:\.\d+)+)_(\d+)\.zip}i)
      strategy :page_match do |page, regex|
        match = page.match(regex)
        next if match.blank?

        "#{match[1]},#{match[2]}"
      end
    end
  end
  on_monterey :or_newer do
    version "7.15,118423570"
    sha256 "f3a47287ef17cfa92b8c86c4ccfb844d14c4d30d3330be9e28f562fe9762304c"

    livecheck do
      url "https://api.renewedvision.com/v1/pro/upgrade?platform=macos&osVersion=#{MacOS.full_version}&appVersion=0&buildNumber=0&includeNotes=0"
      regex(%r{/ProPresenter[._-]v?(\d+(?:\.\d+)+)_(\d+)\.zip}i)
      strategy :page_match do |page, regex|
        match = page.match(regex)
        next if match.blank?

        "#{match[1]},#{match[2]}"
      end
    end
  end

  url "https://renewedvision.com/downloads/propresenter/mac/ProPresenter_#{version.csv.first}_#{version.csv.second}.zip"
  name "ProPresenter"
  desc "Presentation and production application for live events"
  homepage "https://www.renewedvision.com/propresenter.php"

  auto_updates true
  conflicts_with cask: "homebrew/cask-versions/propresenter-beta"
  depends_on macos: ">= :mojave"

  app "ProPresenter.app"

  zap trash: [
        "/Library/Application Support/RenewedVision",
        "/Library/Caches/com.renewedvision.ProPresenter#{version.major}",
        "/Users/Shared/Renewed Vision Media",
        "~/Library/Application Support/RenewedVision/ProPresenter#{version.major}",
        "~/Library/Caches/com.renewedvision.ProPresenter#{version.major}",
        "~/Library/Caches/KSCrashReports/ProPresenter #{version.major}",
        "~/Library/Caches/Sessions/ProPresenter #{version.major}",
        "~/Library/Preferences/com.renewedvision.ProPresenter#{version.major}.plist",
      ],
      rmdir: [
        "~/Library/Application Support/RenewedVision",
        "~/Library/Caches/KSCrashReports",
        "~/Library/Caches/Sessions",
      ]
end
