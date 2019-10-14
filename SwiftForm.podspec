Pod::Spec.new do |s|

  s.name         = "SwiftForm"
  s.version      = "0.0.2"
  s.summary      = "SwiftForm is a library to create forms easily with Swift."

  s.description  = <<-DESC
                   Put a description here
                   DESC

  s.homepage     = "https://github.com/itzseven/SwiftForm"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "itzseven7" => "itzseven7@outlook.fr" }
  
  s.platform     = :ios, "12.1"

  s.source       = { :git => 'https://github.com/itzseven/SwiftForm.git', :tag => s.version.to_s }

  s.swift_version = '4.2'
  s.ios.deployment_target = '12.1'
  s.source_files = 'SwiftForm/**/*.swift'

end
