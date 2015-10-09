
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '6.1'
inhibit_all_warnings!

xcodeproj 'Magic'

target :Magic do
    pod 'AFNetworking','~> 2.3.1'
    pod 'AFNetworkActivityLogger'
    pod 'Reachability'
    pod 'HPGrowingTextView'
    pod 'SMPageControl'
    pod 'SVProgressHUD'
    pod 'APAddressBook'
    pod 'NSDate+Calendar'
    pod 'XRSA'
    pod 'QBImagePickerController'
    pod 'GCPlaceholderTextView'
end

post_install do |installer|
  installer.project.targets.each do |target|
    puts "#{target.name}"
  end
end

