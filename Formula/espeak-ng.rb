# typed: false
# frozen_string_literal: true

class EspeakNg < Formula
  desc "Multi-lingual software speech synthesizer"
  homepage "https://github.com/espeak-ng/espeak-ng"
  url "https://github.com/espeak-ng/espeak-ng/archive/1.51.tar.gz"
  sha256 "f0e028f695a8241c4fa90df7a8c8c5d68dcadbdbc91e758a97e594bbb0a3bdbf"
  head "https://github.com/espeak-ng/espeak-ng"
  

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "kramdown" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "ronn" => :build
  depends_on "chrisvaughn/tap/pcaudiolib"
  depends_on "danielbair/tap/sonic-speech"

  # deal with changing the case of the ChangeLog to the expected case
  patch do
    url "https://raw.githubusercontent.com/chrisvaughn/homebrew-tap/main/patches/espeakng_autogen.diff"
    sha256 "5edd772c39d681d09f8537735c10409714cfdfb8ce6277f925f641ea7393a369"
  end
  
  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}", "--with-extdict-ru", "--with-extdict-zh", "--with-extdict-zhy"
    system "make", "-j1", "src/espeak-ng", "src/speak-ng", "en"
    system "make", "-j1", "install"
  end

  test do
    system "espeak-ng", "Testing.", "-w", "test.wav"
  end
end
