Pod::Spec.new do |s|
  s.name             = "UIAlertBuilder"
  s.version          = "1.0.0"
  s.summary          = "A tiny UIAlertController builder for iOS."
  s.homepage         = "https://github.com/Meniny/UIAlertBuilder"
  s.license          = 'MIT'
  s.author           = { "Elias Abel" => "Meniny@qq.com" }
  s.source           = { :git => "https://github.com/Meniny/UIAlertBuilder.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'UIAlertBuilder/*.*'
  s.module_name = 'UIAlertBuilder'
  s.public_header_files = 'UIAlertBuilder/*.h'
  s.frameworks = 'Foundation', 'UIKit'
end
