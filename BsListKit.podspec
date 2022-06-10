Pod::Spec.new do |s|

  s.name         = 'BsListKit'
  s.version      = '0.0.1'
  s.summary      = 'BsListKit'
  s.homepage     = 'https://github.com/BaldStudio/BsListKit.git'
  s.license      = { :type => 'MIT', :text => 'LICENSE' }
  s.author       = { 'crzorz' => 'crzorz@outlook.com' }
  s.source       = { :git => 'https://github.com/BaldStudio/BsListKit.git', :tag => s.version.to_s }

  s.swift_version = '5.0'
  s.ios.deployment_target = "13.0"
  s.static_framework = true

  s.ios.source_files = 'BsListKit/Source/**/*'

  s.ios.frameworks = 'UIKit'
  
  s.subspec 'Common' do |ss|
      ss.ios.source_files = 'BsListKit/Source/Common/**/*'
  end

  s.subspec 'TableView' do |ss|
      ss.ios.source_files = 'BsListKit/Source/TableView/**/*'
      ss.dependency 'BsListKit/Common'
  end
  
  s.subspec 'CollectionView' do |ss|
      ss.ios.source_files = 'BsListKit/Source/CollectionView/**/*'
      ss.dependency 'BsListKit/Common'
  end

end
