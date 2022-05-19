# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Genrawid < Formula
  desc "generate a unique consistent number from the imput as a rawid of SQLite3."
  homepage "https://github.com/KEINOS/go-genrawid/"
  version "0.0.1"

  on_macos do
    url "https://github.com/KEINOS/go-genrawid/releases/download/v0.0.1/go-genrawid_0.0.1_macOS_all.zip", :using => CurlDownloadStrategy
    sha256 "39b672b353e4e1872a95f28c27862a3b0c646eb919cfbc8da6b28aced4dfd020"

    def install
      bin.install "genrawid"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/KEINOS/go-genrawid/releases/download/v0.0.1/go-genrawid_0.0.1_Linux_armv6.tar.gz", :using => CurlDownloadStrategy
      sha256 "04b7dd59953f757515c102d958aaa6e1514f2099f4fd4a385d8fb5a2de922530"

      def install
        bin.install "genrawid"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/KEINOS/go-genrawid/releases/download/v0.0.1/go-genrawid_0.0.1_Linux_x86_64.tar.gz", :using => CurlDownloadStrategy
      sha256 "2805bfc3c522a562658f7a8a6cbb84929e8b0a0613fe76566d75073252fe925f"

      def install
        bin.install "genrawid"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/KEINOS/go-genrawid/releases/download/v0.0.1/go-genrawid_0.0.1_Linux_arm64.tar.gz", :using => CurlDownloadStrategy
      sha256 "e60b753c7d00412a48f0a8e5d8983ddf713295d45799588e8a0ba8cf9e11c423"

      def install
        bin.install "genrawid"
      end
    end
  end

  test do
    system "#{bin}/genrawid --version"
  end
end
