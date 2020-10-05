#
#  Be sure to run `pod spec lint AppleSignInWrapper.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name = "AppleSignInWrapper"
  spec.version = "1.1"
  spec.summary = "AppleSignInWrapper for iOS"
  spec.description = "An easy way to implement Apple Sign In"
  spec.homepage = "https://github.com/chibombo/AppleIDButtonWrapper"
  spec.license = "MIT"
  spec.author = { "Genaro Arvizu" => "genaro.arvizu.vega@icloud.com" }
  spec.social_media_url = "https://twitter.com/genaro_arvizu"
  spec.platform = :ios, "9.0"
  spec.source = { :git => "https://github.com/chibombo/AppleIDButtonWrapper.git", :tag => spec.version }
  spec.source_files = "Sources/**/*.swift"
  spec.swift_versions = ['5.0', '5.1', '5.2', '5.3']
end
