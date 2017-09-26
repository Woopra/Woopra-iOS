Pod::Spec.new do |s|
  s.name         = "Woopra-iOS"
  s.version      = "1.0.0"
  s.summary      = "Woopra official iOS SDK"
  s.description  = "Woopra official iOS SDK"

  s.homepage     = "http://woopra.com/"
  s.license      = "MIT"
  s.author             = "Woopra"
  s.platform     = :ios, "10.0"

  s.source       = { :git => "https://github.com/Woopra/Woopra-iOS.git", :tag => "#{s.version}" }
  s.source_files = "WoopraSDK", "WoopraSDK/**/*.{h,m,swift}"

end
