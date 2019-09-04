#
#  Be sure to run `pod spec lint AbnormalityLabelView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  
  spec.name         = "AbnormalityLabelView"
  spec.version      = "1.3.0"
  spec.summary      = "collectionview实现不规则标签布局"
  
  spec.description  = <<-DESC
  不规则标签展示
  DESC
  
  spec.homepage     = "https://github.com/zidonJ/AbnormalityLabelView"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  
  spec.license      = "MIT"
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  
  spec.author             = { "zidonJ" => "https://github.com/zidonJ" }
  
  spec.platform     = :ios
  spec.platform     = :ios, "9.0"
  
  spec.ios.deployment_target = "9.0"
  spec.static_framework = true
  spec.source       = { :git => "https://github.com/zidonJ/AbnormalityLabelView.git", :tag => "#{spec.version}" }
  spec.default_subspec =  'AbnormalityView'
  
  # spec.source_files  = "Classes/**/*.{h,m}"
  # # spec.exclude_files = "Classes/*.h"
  # spec.public_header_files = "Classes/**/*.h"
  
  spec.requires_arc = true
  spec.xcconfig = {
    "OTHER_LDFLAGS" => "$(inherited) -ObjC -all_load"
  }
  
  spec.subspec "AbnormalityView" do |ss|
    ss.source_files = "AbnormalityView/*.{h,m}"
    ss.public_header_files = "AbnormalityView/*.h"
    ss.dependency 'AbnormalityLabelView/Corner'
    ss.dependency 'Masonry'
  end
  
  spec.subspec "Drawer" do |ss|
    ss.source_files = "Drawer/*.{h,m}"
    ss.public_header_files = "Drawer/*.h"
    ss.dependency 'Masonry'
  end

  spec.subspec "Corner" do |ss|
    ss.source_files = "Corner/*.{h,m}"
    ss.public_header_files = "Corner/*.h"
  end
  
  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"
  
end
