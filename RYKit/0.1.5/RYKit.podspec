Pod::Spec.new do |spec|

  
  spec.name         = "RYKit"
  spec.version      = "0.1.5"
  spec.summary      = "RYKit is a internal framework  to develop iOS faster."


  spec.homepage     = "http://192.168.1.111:8082/gitlab/marc/RYKit"


  
  spec.license      = "MIT "


  
  spec.author             = { "MarcSteven" => "marc@richandyoung.cn" }
  spec.social_media_url   = "https://www.richandyoung.cn"

  

   spec.ios.deployment_target = "10.0"
  

  
  spec.source       = { :git => "http://192.168.1.111:8082/gitlab/marc/RYKit", :tag => "#{spec.version}" }


  spec.swift_versions = ['5.0','5.1']
  spec.source_files  = "RYKit/Sources/**/*.swift"
  spec.frameworks = ['UIKit','Foundation']
    


  
end
