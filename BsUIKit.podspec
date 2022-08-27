Pod::Spec.new do |s|

  s.name         = 'BsUIKit'
  s.version      = '0.0.1'
  s.summary      = 'BsUIKit'
  s.homepage     = 'https://github.com/BaldStudio/BsUIKit.git'
  s.license      = { :type => 'MIT', :text => 'LICENSE' }
  s.author       = { 'crzorz' => 'crzorz@outlook.com' }
  s.source       = { :git => 'https://github.com/BaldStudio/BsUIKit.git', :tag => s.version.to_s }

  s.swift_version = '5.0'
  s.static_framework = true

  s.ios.deployment_target = "13.0"
  s.ios.source_files = 'BsUIKit/Source/**/*'

  s.ios.frameworks = 'UIKit'
  
  s.ios.dependency 'BsFoundation'
  
  s.subspec 'ViewControllers' do |ss|
    ss.ios.source_files = 'BsUIKit/Source/ViewControllers/**/*'
  end

  s.subspec 'TableView' do |ss|
    ss.ios.source_files = 'BsUIKit/Source/TableView/**/*'
    ss.ios.dependency 'ViewControllers'
  end
  
  s.subspec 'CollectionView' do |ss|
    ss.ios.source_files = 'BsUIKit/Source/CollectionView/**/*'
    ss.ios.dependency 'ViewControllers'
  end
    
  s.subspec 'WebView' do |ss|
    ss.ios.source_files = 'BsUIKit/Source/WebView/**/*'
    ss.ios.dependency 'ViewControllers'
  end

  s.subspec 'Widgets' do |ss|
    ss.ios.source_files = 'BsUIKit/Source/Widgets/**/*'
  end

end
