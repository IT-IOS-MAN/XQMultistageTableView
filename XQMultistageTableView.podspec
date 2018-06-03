Pod::Spec.new do |s|
s.name = 'XQMultistageTableView'
s.version = '0.0.1'
s.license = 'MIT'
s.summary = '多级菜单'
s.homepage = 'https://github.com/weakGG/XQMultistageTableView'
s.authors = { 'WeakGG' => '917709989@qq.com' }
s.source = { :git => "https://github.com/weakGG/XQMultistageTableView.git", :tag => "0.0.1"}
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = "XQMultistageTableView/XQMultistageTableView/XQMultistageTableView/*.{h,m}", "XQMultistageTableView/XQMultistageTableView/XQMultistageTableView/Model/*.{h,m}", "XQMultistageTableView/XQMultistageTableView/XQMultistageTableView/View/*.{h,m}"
s.resources = "XQMultistageTableView/XQMultistageTableView/XQMultistageTableView.bundle"
s.frameworks = 'UIKit'
end