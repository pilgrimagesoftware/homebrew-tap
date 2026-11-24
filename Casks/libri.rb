cask "libri" do
  version "1.2.0"
  sha256 "97bf640ab6072532b1f487d542869ab9699f45bb9514247e340840c3f61b7ae3"

  url "https://github.com/pilgrimagesoftware/dtrpg-app.rs/releases/download/v#{version}/Libri_#{version}_aarch64.dmg"
  name "Libri"
  desc "Desktop library manager for DriveThruRPG"
  homepage "https://pilgrimagesoftware.github.io/dtrpg-app.rs/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :big_sur

  app "Libri.app"

  # The shipped signature is invalid and dyld rejects the app at launch, so
  # re-sign ad hoc and clear quarantine, which Gatekeeper would block.
  postflight_steps do
    run "/usr/bin/codesign", args: ["--force", "--deep", "--sign", "-", "Libri.app"], chdir: "{{appdir}}"
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "Libri.app"], chdir: "{{appdir}}"
  end
end
