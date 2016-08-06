
Pod::Spec.new do |s|
  s.name         = "SwiftAlertController"
  s.version      = "1.0.4"
  s.summary      = "This is the Swift support UIAlertView and UIAlertController version of third-party libraries"
  s.description  = <<-DESC
  This is the Swift support UIAlertView and UIAlertController version of third-party libraries(这是支持UIAlertView和UIAlertController 的Swift 版本的第三方库)
                   DESC
  s.homepage     = "https://github.com/15038777234/SwiftAlertController"
  s.license      = "MIT"
  s.author             = { "15038777234" => "15038777234@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/15038777234/SwiftAlertController.git", :tag => s.version }
  s.source_files  = "Classes/*.swift"
  s.requires_arc = true
end
