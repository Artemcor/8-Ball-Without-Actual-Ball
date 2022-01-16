# iOS Magic Eight Ball App


![Platforms](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)
[![Swift Version](https://img.shields.io/badge/Swift-5-F16D39.svg?style=flat)](https://developer.apple.com/swift)
![Telegram](https://img.shields.io/badge/Telegram-@artemcore-blue.svg)

Shake phone and application will give random answer using API request. If there is internet connection isseue you will receive one of hardcoded answers.

![Image alt]()

## Shown concepts

### Architecture concepts

* MVVM
* Coordinators
* Navigation Node
* Data Binding
* Dependency Injection

## Conventions

- You should use Coordinator pattern for navigation 
- You should use MVVM architecture
- You should use CoreData to work with data base
- You shouldn't use UIKit in other flow except View 
- All string and images should be use by Swiftgen, not hardcode

## Dependencies

- [RxSwift](https://github.com/ReactiveX/RxSwift) - Reactive Programming in Swift 
- [SwiftLint](https://github.com/realm/SwiftLint) - A tool to enforce Swift style and conventions
- [SwiftGen](https://github.com/SwiftGen/SwiftGen) - A tool to automatically generate Swift code for resources of your projects
- [SwiftKeychainWrapper](https://github.com/jrendel/SwiftKeychainWrapper) - A simple wrapper for the iOS / tvOS Keychain to allow you to use it in a similar fashion to User Defaults. Written in Swift

## Author

Artem Stozhok - iartemsto@gmail.com

