#
# Be sure to run `pod lib lint RouterKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RouterKit'
  s.version          = '0.3.0'
  s.summary          = 'A short description of RouterKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'git@134.175.230.26:iOS_Compoent/RouterKit.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiaozhan' => 'Yu.Wang@zhan.com' }
  s.source           = { :git => 'git@134.175.230.26:iOS_Compoent/RouterKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'RouterKit/Classes/*.{h,m}'
  
  # s.resource_bundles = {
  #   'RouterKit' => ['RouterKit/Assets/*.png']
  # }

   s.public_header_files = 'RouterKit/Classes/XZRouterKit.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'MJExtension'
end
