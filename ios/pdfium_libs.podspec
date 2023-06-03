# #
# # To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# # Run `pod lib lint pdfium_libs.podspec` to validate before publishing.
# #
# Pod::Spec.new do |s|
#   s.name             = 'pdfium_libs'
#   s.version          = '0.0.1'
#   s.summary          = 'A new Flutter FFI plugin project.'
#   s.description      = <<-DESC
# A new Flutter FFI plugin project.
#                        DESC
#   s.homepage         = 'http://example.com'
#   s.license          = { :file => '../LICENSE' }
#   s.author           = { 'Your Company' => 'email@example.com' }

#   # This will ensure the source files in Classes/ are included in the native
#   # builds of apps using this FFI plugin. Podspec does not support relative
#   # paths, so Classes contains a forwarder C file that relatively imports
#   # `../src/*` so that the C sources can be shared among all target platforms.
#   s.source           = { :path => '.' }
#   s.source_files = 'Classes/**/*'
#   s.dependency 'Flutter'
#   s.platform = :ios, '11.0'
#   s.library  = 'c++'
#   # Flutter.framework does not contain a i386 slice.
#   # s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
#   s.swift_version = '5.0'
 
#    # telling CocoaPods not to remove framework
#    s.preserve_paths = 'pdfium.framework' 
 
#    # telling linker to include pdfium framework
#    s.xcconfig = { 'OTHER_LDFLAGS' => '-framework pdfium' }
 
#    # including pdfium framework
#    s.vendored_frameworks = 'pdfium.framework' 
 
#    # including C++ library
#    s.library = 'c++'
# end


# ref:https://github.com/bitsydarel/dart_ffi_static_link_issue/blob/685c327486856a595a6fab4938686bd8d2e6d7a6/ios/dart_ffii_static_link_issue.podspec#L4
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint dart_ffii_static_link_issue.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'pdfium_libs'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter FFI plugin project.'
  s.description      = <<-DESC
A new Flutter FFI plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform         = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.libraries = ["c++", "z"]
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.vendored_libraries = 'pdfium.xcframework/ios-arm64/libpdfium.a'
  s.pod_target_xcconfig = { "OTHER_LDFLAGS" => "-force_load $(PODS_TARGET_SRCROOT)/pdfium.xcframework/ios-arm64/libpdfium.a" }
  s.swift_version = '5.0'
end