Pod::Spec.new do |s|

  s.platform = :ios
  s.ios.deployment_target = '11.0'
  s.name         = "AlamofireInterceptor"
  s.version      = "0.0.1"
  s.summary      = "Intercept Alamofire network requests and responses."
  s.requires_arc = true

  s.description  = <<-DESC
Intercept Alamofire network requests and responses and make changes to the requests and the responses to help test and debug.
                   DESC


  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Yehia Elbehery" => "yehia.elbehery@gmail.com" }

  s.homepage     = "https://github.com/yehiaelbehery/AlamofireInterceptor"

  s.source = { :git => "https://github.com/yehiaelbehery/AlamofireInterceptor.git",
:tag => "#{s.version}" }

s.framework = "UIKit"

s.dependency 'Alamofire', '~> 4.7'

s.source_files = "AlamofireInterceptor/**/*.{swift}"

s.resources = "AlamofireInterceptor/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

s.swift_version = "4.2"

end
