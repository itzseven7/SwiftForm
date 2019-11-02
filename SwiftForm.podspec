Pod::Spec.new do |s|

  s.name         = "SwiftForm"
  s.version      = "0.0.3"
  s.summary      = "A Swift library to write forms easily."
  s.homepage     = "https://github.com/itzseven7/SwiftForm"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "itzseven7" => "itzseven7@outlook.fr" }
  
  s.source       = { :git => 'https://github.com/itzseven7/SwiftForm.git', :tag => s.version.to_s }

  s.swift_version = '4.2', '5.0'
  s.ios.deployment_target = '11.0'
  s.source_files = 'SwiftForm/**/*.swift'

end
