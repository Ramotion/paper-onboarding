
Pod::Spec.new do |s|

  s.name         = "paper-onboarding"
  s.version      = "2.1"
  s.summary      = "Amazing onboarding."
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/Ramotion/paper-onboarding'
  s.author       = { 'Hari Balamani' => '' }
  s.ios.deployment_target = '9.0'
  s.source       = { :git => 'https://github.com/Ramotion/paper-onboarding.git', :tag => s.version.to_s }
  s.source_files  = 'Source/**/*.swift'
  end
