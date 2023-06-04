#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint plugin_ffi.podspec` to validate before publishing.
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
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'
  s.library  = 'c++'
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
  s.static_framework = true
  # telling CocoaPods not to remove framework
  s.preserve_paths = 'pdfium.xcframework' 
  # including pdfium framework
  s.vendored_libraries = 'pdfium.xcframework/ios-arm64/libpdfium.a'
end

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
#   s.source           = { :path => '.' }
#   s.source_files     = 'Classes/**/*'
#   # This will ensure the source files in Classes/ are included in the native
#   # builds of apps using this FFI plugin. Podspec does not support relative
#   # paths, so Classes contains a forwarder C file that relatively imports
#   # `../src/*` so that the C sources can be shared among all target platforms.
#   s.dependency 'Flutter'
#   s.platform = :ios, '11.0'
#   s.vendored_libraries = 'Frameworks/libpdfium.dylib'
#   s.library  = 'c++'
#   # Flutter.framework does not contain a i386 slice.
#   s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
#   s.swift_version = '5.0'
# end
