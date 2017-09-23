Pod::Spec.new do |s|
  s.name         = "WoopraSDK"
  s.version      = "0.0.1"
  s.summary      = "A short description of WoopraSDK."
  s.description  = "A short description of WoopraSDK. A short description of WoopraSDK. A short description of WoopraSDK. A short description of WoopraSDK."

  s.homepage     = "http://woopra.com/"
  s.license      = "MIT"
  s.author             = "Woopra"
  s.platform     = :ios, "10.0"

  s.source       = { :git => "https://github.com/Woopra/Woopra-iOS.git", :tag => "#{s.version}" }
  s.source_files = "WoopraSDK", "WoopraSDK/**/*.{h,m,swift}"

end
