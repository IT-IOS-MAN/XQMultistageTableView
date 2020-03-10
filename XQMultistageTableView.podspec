Pod::Spec.new do |s|
s.name = 'XQMultistageTableView'
s.version = '1.0.3'
s.license = 'MIT'
s.summary = '多级菜单'
s.homepage = 'https://github.com/weakGG/XQMultistageTableView'
s.authors = { 'WeakGG' => '917709989@qq.com' }
s.source = { :git => "https://github.com/weakGG/XQMultistageTableView.git", :tag => "1.0.3"}
s.requires_arc = true
s.ios.deployment_target = '6.0'
s.source_files = "XQMultistageTableView/XQMultistageTableView/*.{h,m}", "XQMultistageTableView/XQMultistageTableView/**/*.{h,m}"
s.resource = "XQMultistageTableView/XQMultistageTableView/XQMultistageTableView.bundle"
s.frameworks = 'UIKit'
end
