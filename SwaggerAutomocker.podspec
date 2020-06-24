#
# Be sure to run `pod lib lint SwaggerAutomocker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwaggerAutomocker'
  s.version          = '0.1.4'
  s.summary          = 'An automatic mock server to speed up your initial development using swagger json.'
  s.swift_version    = '5.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
SwaggerAutomocker will read a swagger json file and launch a mock server which will respond to all calls to the endpoints defined in swagger json.
                       DESC

  s.homepage         = 'https://github.com/lngyeen/SwaggerAutomocker'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lngyeen' => 'lngyeen@openwt.com' }
  s.source           = { :git => 'https://github.com/lngyeen/SwaggerAutomocker.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'SwaggerAutomocker/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SwaggerAutomocker' => ['SwaggerAutomocker/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

  s.dependency 'Telegraph', '~> 0.28.0'
  s.dependency 'ObjectMapper', '~> 3.5.0'
end
