#
# Be sure to run `pod lib lint ERComponent.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ERComponent'
  s.version          = '0.0.4'
  s.summary          = 'Eric 网络收集常用组件库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ocswor'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jialianghappy1314@163.com' => 'yijialiang@stormorai.com' }
  s.source           = { :git => 'https://github.com/ocswor/ERComponent.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

#s.source_files = 'ERComponent/Classes/**/*'
  s.subspec 'Base' do |b|
    b.source_files = 'ERComponent/Classes/Base/**/*'
  end

  s.subspec 'BaseCategory' do |bc|
    bc.source_files = 'ERComponent/Classes/BaseCategory/**/*'
    bc.dependency 'SDWebImage', '~> 4.1.2'
  end

  s.subspec 'Network' do |n|
    n.source_files = 'ERComponent/Classes/Network/**/*'
    n.dependency 'AFNetworking', '~> 3.1.0'
  end

  s.subspec 'Tool' do |t|
    t.source_files = 'ERComponent/Classes/Tool/**/*'
  end

  s.subspec 'CircleCarousel' do |circle|
    circle.source_files = 'ERComponent/Classes/CircleCarousel/**/*'
  end

    s.subspec 'ERDownloader' do |downloader|
    downloader.source_files = 'ERComponent/Classes/ERDownloader/**/*'
    end

  # s.resource_bundles = {
  #   'ERComponent' => ['ERComponent/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
