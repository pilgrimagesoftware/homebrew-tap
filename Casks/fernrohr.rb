cask "fernrohr" do
  version "0.17.0"
  sha256 "7d98f54ccc88a3d20eb794071d10094277a0239de4d4a496ee19eb5d3a1851e8"

  url "https://github.com/pilgrimagesoftware/Fernrohr-App/releases/download/v#{version}/Fernrohr_#{version}_aarch64.dmg"
  name "Fernrohr"
  desc "Desktop UI for Kubernetes cluster monitoring"
  homepage "https://github.com/pilgrimagesoftware/Fernrohr-App"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :big_sur

  app "Fernrohr.app"

  # Release builds carry an ad-hoc signature (signing-identity "-" in
  # app/Cargo.toml) unless Developer ID credentials are set, so Gatekeeper
  # blocks a quarantined copy.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "Fernrohr.app"], chdir: "{{appdir}}"
  end
end
