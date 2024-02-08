class Sigi < Formula
  desc "Organizing tool for terminal lovers that hate organizing"
  homepage "https://sigi-cli.org"
  url "https://static.crates.io/crates/sigi/sigi-3.6.3.crate"
  sha256 "15f5ebbe7e51bdc3236f69371805deebbbdd730519cc8e680ba78206b668d96d"
  license "GPL-2.0-only"
  head "https://github.com/sigi-cli/sigi.git", branch: "core"

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
