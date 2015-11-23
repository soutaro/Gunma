Pod::Spec.new do |spec|
  spec.name             = 'Gunma'
  spec.version          = '0.2.0'
  spec.license          = 'MIT'
  spec.homepage         = 'https://github.com/soutaro/Gunma'
  spec.authors          = { 'Soutaro Matsumoto' => 'matsumoto@soutaro.com' }
  spec.summary          = 'Graph Library for Swift'
  spec.source           = { :git => 'https://github.com/soutaro/Gunma.git', :tag => spec.version.to_s }
  spec.source_files     = 'Gunma/*.swift'
  spec.requires_arc     = true
  spec.ios.deployment_target = "8.0"
  spec.requires_arc     = true
end
