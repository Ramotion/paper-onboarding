
Pod::Spec.new do |s|

  s.name         = "paper-onboarding"
  s.version      = "1.1.7"
  s.summary      = "Amazing onboarding."
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/Eyez-io/paper-onboarding'
  s.author       = { 'Noam Etzion-Rosenberg' => 'noam@eyez.io' }
  s.ios.deployment_target = '8.0'
  s.source       = { :git => 'https://github.com/Eyez-io/paper-onboarding.git', :tag => s.version.to_s }
  s.source_files  = 'Source/**/*.swift'
  s.requires_arc = true
  end
