
Pod::Spec.new do |s|

  s.name         = "paper-onboarding"
  s.version      = "3.0.0"
  s.summary      = "Amazing onboarding."
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/Ramotion/paper-onboarding'
  s.author       = { 'Juri Vasylenko' => 'juri.v@ramotion.com' }
  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.source       = { :git => 'https://github.com/Ramotion/paper-onboarding.git', :tag => s.version.to_s }
  s.source_files  = 'Source/**/*.swift'
  s.deprecated_in_favor_of = 'PaperOnboarding'
  end
