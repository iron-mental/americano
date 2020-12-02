# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Terminal-iOS' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'SwiftLint'
  pod 'Then'
  pod 'NMapsMap'
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'Kingfisher'
  pod 'Socket.IO-Client-Swift', '~> 13.0.0'
# Pods for Terminal-iOS
  
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
end
