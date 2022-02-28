# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Whereami < Formula
  desc "This is a command line utility that prints the current global/public IP address."
  homepage "https://github.com/KEINOS/whereami/"
  version "0.0.0-alpha"

  on_macos do
    url "https://github.com/KEINOS/whereami/releases/download/v0.0.0-alpha/whereami_0.0.0-alpha_macOS_all.zip", :using => CurlDownloadStrategy
    sha256 "955571b564135107a50b1e92ffb73337d9fe70ebdf19e3e8c060b05213ea5341"

    def install
      bin.install "whereami"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/KEINOS/whereami/releases/download/v0.0.0-alpha/whereami_0.0.0-alpha_Linux_arm64.tar.gz", :using => CurlDownloadStrategy
      sha256 "fea2848a51aae17c760d44e569457c2381ec0f8560c4730061881ca21fd48ab4"

      def install
        bin.install "whereami"
      end
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/KEINOS/whereami/releases/download/v0.0.0-alpha/whereami_0.0.0-alpha_Linux_armv6.tar.gz", :using => CurlDownloadStrategy
      sha256 "04879ea5ad6d07906249daab4b59eaaeecee0e6a0666b45aabd653f308796b80"

      def install
        bin.install "whereami"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/KEINOS/whereami/releases/download/v0.0.0-alpha/whereami_0.0.0-alpha_Linux_x86_64.tar.gz", :using => CurlDownloadStrategy
      sha256 "b70c546a098432806d07c68ab0a165479c6736442c05beb9daf092aa2ccf4c31"

      def install
        bin.install "whereami"
      end
    end
  end

  test do
    system "#{bin}/whereami --version"
  end
end
