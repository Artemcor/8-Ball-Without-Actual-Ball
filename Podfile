# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

target '8-Ball Without Actual Ball' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for 8-Ball Without Actual Ball
	pod 'SwiftLint'
	pod 'SwiftGen', '~> 6.0'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end

end