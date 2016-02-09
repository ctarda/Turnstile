# Turnstile
[![Build Status](https://travis-ci.org/ctarda/Turnstile.svg?branch=master)](https://travis-ci.org/ctarda/Turnstile)
[![Version](https://img.shields.io/cocoapods/v/Turnstile.svg?style=flat)](http://cocoapods.org/pods/Turnstile)
[![License](https://img.shields.io/cocoapods/l/Turnstile.svg?style=flat)](http://cocoapods.org/pods/Turnstile)
[![Platform](https://img.shields.io/cocoapods/p/Turnstile.svg?style=flat)](http://cocoapods.org/pods/Turnstile)

Turnstile is a lightweight implementation of a [Finite State Machine](http://en.wikipedia.org/wiki/Finite-state_machine) in Swift.

Turnstile is inspired by some of the existing open source implementations of State Machines in Swift, in particular:
* [Transporter](https://github.com/DenHeadless/Transporter)
* [SwiftyStateMachine](https://github.com/macoscope/SwiftyStateMachine)

Turnstile aims to be simple to use, while maintaning a clean API.

Turnstile builds as a framework, and therefore needs iOS 8.

Turnstile has been migrated to Swift 2, and therefore it requires Xcode 7.

## Installation
If you want to install Turnstile manually just include all the Swift files in Sources/Turnstile in your project.

Turnstile is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
use frameworks!
pod 'Turnstile'
```

If you use the Swift Package Manager, add it to the dependencies of your Package.swift file:

```ruby
import PackageDescription

let package = Package(
    //
    dependencies: [
        //
        .Package(url: "https://github.com/ctarda/Turnstile.git", majorVersion: 1, minor: 1)
    ]
)
```

## Author

Cesar Tardaguila, https://twitter.com/ctarda

## License

Turnstile is available under the MIT license. See the LICENSE file for more info.
