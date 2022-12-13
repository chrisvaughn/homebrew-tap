# typed: false
# frozen_string_literal: true

class Pcaudiolib < Formula
  desc "Portable C Audio Library"
  homepage "https://github.com/espeak-ng/pcaudiolib"
  url "https://github.com/espeak-ng/pcaudiolib/archive/1.2.tar.gz"
  sha256 "44b9d509b9eac40a0c61585f756d76a7b555f732e8b8ae4a501c8819c59c6619"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  # deal with changing the case of the ChangeLog to the expected case
  patch do
    url "https://raw.githubusercontent.com/chrisvaughn/homebrew-tap/45722baf904d4db8a1e9b13fc43a4d9dbc267639/patches/pcaudiolib_autogen.diff"
    sha256 "98f5234f456a93e92d25321b099e25971dce243e74fb00b8d5db98325858cb1e"
  end

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make", "PREFIX=#{prefix}"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system "false"
  end
end
