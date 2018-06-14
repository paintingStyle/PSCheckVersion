Pod::Spec.new do |s|

s.name         = "PSCheckVersion"
s.version      = "0.1.0"
s.summary      = "一键检测App更新，并附带UI可直接使用"

s.homepage     = "https://github.com/paintingStyle/PSCheckVersion"
s.license      = "MIT"
s.author       = { "paintingStyle" => "sfdeveloper@163.com" }
s.platform     = :ios,'8.0'

s.source       = { :git => "https://github.com/paintingStyle/PSCheckVersion.git", :tag => "#{s.version}" }
s.source_files = "PSCheckVersion/**/*.{h,m}"
s.dependency "Masonry", "~> 1.1.0"
s.requires_arc = true

end
