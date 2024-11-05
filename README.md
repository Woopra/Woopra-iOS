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
    pod 'WoopraSDK', '1.2.1'
end
```

Then, run the following command:

```bash
$ pod install
```

### Swift Package Manager

#### Installing from Xcode(using Xcode15.3 for example)

1. Add a package by selecting `File` → `Add Package Dependencies...` in Xcode’s menu bar.
2. Search for the `WoopraSDK` using the repo's URL: `https://github.com/Woopra/Woopra-iOS.git`
3. Set the `Dependency Rule` to be `Exact Version` with version `1.2.1`
4. Select `Add Package`.

#### Alternatively, integrate WoopraSDK in your `Package.swift` file(swift-tools-version:5.0)

```swift
dependencies: [
    .package(url: "https://github.com/Woopra/Woopra-iOS.git", from: "1.2.1")
]
```

Then, add the dependency to your target:

```swift
targets: [
    .target(
        name: "YourAppName",
        dependencies: [
            .product(name: "Woopra", package: "Woopra-iOS")]
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

## Advanced Settings

To add referrer information, timestamp, and other track request properties, look at the `WoopraTracker` and `WoopraEvent` class public methods for an exhaustive list of setter methods.  Here are some common examples:

### Tracker Settings

#### Track Referrer

To add referrer information, set the referer property in your WTracker instance:

``` swift
WTracker.shared.referer = <REFERRER_STRING>
```

#### Idle Timeout

You can update your idle timeout (default: 5 minutes) by updating the timeout property in your WTracker instance:

``` swift
WTracker.shared.idleTimeout = 360
```

> [!NOTE]
> The idle timeout is in seconds.
