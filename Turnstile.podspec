
Pod::Spec.new do |s|
  s.name             = "Turnstile"
  s.version          = "1.1.0"
  s.summary          = "Turnstile is a lightweight implementation of a Finite State Machine in Swift."
  s.description      = <<-DESC
Turnstile is a lightweight implementation of a [Finite State Machine](http://en.wikipedia.org/wiki/Finite-state_machine) in Swift.

Turnstile is inspired by some of the existing open source implementations of State Machines in Swift, in particular:
* [Transporter](https://github.com/DenHeadless/Transporter)
* [SwiftyStateMachine](https://github.com/macoscope/SwiftyStateMachine)

Turnstile aims to be simple to use, while maintaning a clean API.

Turnstile builds as a framework, and therefore needs iOS 8.
                       DESC
  s.homepage         = "https://github.com/ctarda/Turnstile"
  s.license          = { type: "MIT", file: "LICENSE" }
  s.author           = { "Cesar Tardaguila" => "cesar@ctarda.com" }
  s.source           = { :git => "https://github.com/ctarda/Turnstile.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ctarda'

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.tvos.deployment_target = '9.0'

  s.source_files = 'Sources/Turnstile/**/*.{swift,h}'

end
