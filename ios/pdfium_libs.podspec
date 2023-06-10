
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint mylib.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'pdfium_libs'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.public_header_files = 'Classes/*.h'
  s.source_files = 'Classes/**/*'
  s.static_framework = true
  s.ios.vendored_frameworks = 'pdfium.xcframework'
  s.xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++11',
    'CLANG_CXX_LIBRARY' => 'libc++',
    "OTHER_LDFLAGS": '-ObjC -all_load -l"pdfium"'
  }
  s.library = 'c++'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'
  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end