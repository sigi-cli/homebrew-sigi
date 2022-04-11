class Sigi < Formula
  desc "Organizing tool for terminal lovers that hate organizing"
  license "GPL-2.0-only"
  homepage "https://github.com/hiljusti/sigi"
  url "https://crates.io/api/v1/crates/sigi/3.1.1/download"
  sha256 "6d063ff4763e7f6925f0ca85563c2e7008e18983d66051361122d1f477bfd77d"
  head "https://github.com/hiljusti/sigi.git"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release"

    bin.install "target/release/sigi"

    man1.install "sigi.1"
  end

  test do
    system "#{bin}/sigi", "--version"
  end
end
