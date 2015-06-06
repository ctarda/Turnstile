#
# Be sure to run `pod lib lint Turnstile.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Turnstile"
  s.version          = "0.1.0"
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
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Cesar Tardaguila" => "cesar@ctarda.com" }
  s.source           = { :git => "https://github.com/ctarda/Turnstile.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ctarda'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'Turnstile' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
