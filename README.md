# Woopra iOS SDK Documentation

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate the SDK into your Xcode project using CocoaPods, please, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'WoopraSDK', '1.2.0'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate the SDK into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "Woopra/Woopra-iOS"
```

Run `carthage update` to build the framework and drag the built `Woopra.framework` into your Xcode project.

### Swift Package Manager

#### Installing from Xcode(using Xcode15.3 for example)

1. Add a package by selecting `File` → `Add Package Dependencies...` in Xcode’s menu bar.
2. Search for the `WoopraSDK` using the repo's URL: `https://github.com/Woopra/Woopra-iOS.git`
3. Set the `Dependency Rule` to be `Exact Version` with version `1.2.0`
4. Select `Add Package`.

#### Alternatively, integrate WoopraSDK in your `Package.swift` file(swift-tools-version:5.0)

```swift
dependencies: [
    .package(url: "https://github.com/Woopra/Woopra-iOS.git", from: "1.2.0")
]
```

Then, add `WoopraSDK` as a dependency for your target:

```swift
targets: [
    .target(
        name: "YourAppName",
        dependencies: [
                .product(name: "WoopraSDK", package: "Woopra-iOS")]
    )
]
```

## Usage

### Instantiate Tracker

```swift
import Woopra
```

When the app loads, you should load the Woopra Tracker and configure it.

``` swift
WTracker.shared.domain = "mybusiness.com"
```

You can update your idle timeout (default: 60 seconds) by updating the timeout property in your WTracker instance:

``` swift
WTracker.shared.idleTimeout = 30
```

### Event Tracking

To track an `appview` event:

``` swift
// create event "appview"
let event = WEvent.event(name: "appview")
// add property "view" with value "login-view"
event.add(property: "view", value: "login-view")
// track event
WTracker.shared.trackEvent(event)
```

### Identifying

To add custom visitor properties, you should edit the visitor object.

``` swift
WTracker.shared.visitor.add(property: "name", value: "John Smith")
WTracker.shared.visitor.add(property: "email", value: "john@smith.com")
```

You can then send an identify call without tracking an event by using the push method:

``` swift
WTracker.shared.push()
```
