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
  pod 'SwiftKeychainWrapper'
  pod 'Socket.IO-Client-Swift', '~> 15.2.0'
  pod 'lottie-ios'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Analytics'
# Pods for Terminal-iOS
  
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
end
