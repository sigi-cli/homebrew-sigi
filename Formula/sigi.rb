class Sigi < Formula
  desc "Organizing tool for terminal lovers that hate organizing"
  license "GPL-2.0-only"
  homepage "https://github.com/hiljusti/sigi"
  url "https://static.crates.io/crates/sigi/sigi-3.3.0.crate"
  sha256 "6ee073958cf0ad0d78efab105e89c5d5711907d2de5046c0cbe74c43f2e0810d"
  head "https://github.com/hiljusti/sigi.git", branch: "core"

  depends_on "rust" => :build

  def install
    # When using --head, Homebrew does a git clone and the install method
    # is run from the context of that directory.
    unless build.head?
      # Otherwise, the create file is downloaded to a temporary directory, and
      # then the install method is run from that directory, so we need to
      # extract that crate file first. A crate file is just a tarball with a
      # different file extension.
      system "tar", "--strip-components", "1", "-xzvf", "sigi-#{version}.crate"
    end

    system "cargo", "install", *std_cargo_args
    bin.install "target/release/sigi"
    man1.install "sigi.1"
  end

  test do
    system "#{bin}/sigi", "--version"
  end
end
