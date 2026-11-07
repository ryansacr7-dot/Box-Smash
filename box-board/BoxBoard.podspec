Pod::Spec.new do |s|
  s.name = 'BoxBoard'
  s.version = '1.0.0'
  s.summary = 'Reads the Box Smash Game Center leaderboard (scores, names and character codes).'
  s.license = 'MIT'
  s.homepage = 'https://github.com/ryansacr7-dot/Box-Smash'
  s.author = 'Ryan'
  s.source = { :git => 'https://github.com/ryansacr7-dot/Box-Smash.git', :tag => s.version.to_s }
  s.source_files = '*.{swift,h,m}'
  s.ios.deployment_target = '13.0'
  s.dependency 'Capacitor'
  s.frameworks = 'GameKit'
  s.swift_version = '5.1'
end
