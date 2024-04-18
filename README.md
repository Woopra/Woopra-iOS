## Woopra iOS SDK Documentation

### Instantiate Tracker
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

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate WoopraSDK into your Xcode project using CocoaPods, please, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'Woopra-iOS'
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

To integrate Woopra iOS SDK into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "Woopra/Woopra-iOS"
```

Run `carthage update` to build the framework and drag the built `WoopraSDK.framework` into your Xcode project.
