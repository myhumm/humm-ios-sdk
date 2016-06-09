#
# Be sure to run `pod lib lint HummAPI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "HummAPI"
  s.version          = "0.5.11"
  s.summary          = "Your free music service."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "pod to humm API "

  s.homepage         = "https://github.com/myhumm/humm-ios-sdk"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Jose Alonso García" => "josealonsogarcia@gmail.com" }
  s.source           = { :git => "https://github.com/myhumm/humm-ios-sdk", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HummAPI/Classes/**/*'
  s.resource_bundles = {
    'HummAPI' => ['HummAPI/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'JSONModel'
  s.dependency 'AFNetworking', '~> 2.5'

    #  s.dependency 'AFNetworking', :git =>'https://github.com/AFNetworking/AFNetworking.git'

end
