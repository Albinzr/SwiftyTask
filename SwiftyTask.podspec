Pod::Spec.new do |s|
  s.name         = "SwiftyTask"
  s.version      = "0.0.7"
  s.summary      = "An extream queuing system with high performance for managing all task in app with closure"
  s.homepage     = "https://github.com/Albin-CR"
  s.license      = 'MIT'
  s.author       = { "Albin CR" => "albin.git@gmail.com" }
  s.source       = { :git => "https://github.com/CR-Creations/SwiftyTask.git", :tag => "#{s.version}" }
  s.swift_version = "4.1"
  s.requires_arc = true
  s.platform     = :ios, '10.0'

  s.source_files  = "SwiftyTask", "SwiftyTask/**/*.swift"
  
end
