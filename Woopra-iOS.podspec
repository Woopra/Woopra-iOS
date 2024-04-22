Pod::Spec.new do |s|
  s.name         = "WoopraSDK"
  s.version      = "1.1.0"
  s.summary      = "Woopra official iOS SDK"
  s.description  = "Woopra official iOS SDK. Woopra helps you gain deep insight into who your customers are, create relevant engagements, and ultimately make better business decisions. At Woopra’s core is an advanced user tracking technology that automatically profiles each user through detailed behavioral and demographic data in real-time. Woopra’s analytics and automation tools allow you to leverage this information to turn data into action and results."

  s.homepage     = "http://woopra.com/"
  s.license      = "MIT"
  s.author       = "Woopra"
  s.platform     = :ios, "12.0"
  s.swift_versions = ['5.0']

  s.source       = { :git => "https://github.com/Woopra/Woopra-iOS.git", :tag => "#{s.version}" }
  s.source_files = "WoopraSDK", "WoopraSDK/**/*.{h,m,swift}"

end
