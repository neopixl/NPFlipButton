Pod::Spec.new do |s|
  s.name = 'NPFlipButton'
  s.version = '1.0.1'
  s.license = 'Apache 2.0'
  s.summary = 'This is a simple button with a circle at right, who will animate when changing state.'
  s.homepage = 'https://github.com/neopixl/NPFlipButton'
  s.social_media_url = 'http://twitter.com/neopixl'
  s.authors = { 'Neopixl S.A.' => 'contact@neopixl.com' }
  s.source = { :git => 'https://github.com/neopixl/NPFlipButton.git', :tag => s.version }
  s.platform = :ios
  s.ios.deployment_target = '8.0'

  s.source_files = 'NPButtonFlip/Classes/*/*.swift'

  s.requires_arc = true
end
