<h2>Woopra iOS SDK Documentation</h2>

![](https://www.woopra.com/wp-content/uploads/2015/03/woopra-logo.png)

When the app loads, you should load the Woopra Tracker and configure it.

``` swift
WTracker.shared.domain = "mybusiness.com"
```

You can update your idle timeout (default: 60 seconds) by updating the timeout property in your WTracker instance:

``` swift
WTracker.shared.idleTimeout = 30
```

If you want to keep the user online on Woopra even if they don't commit any event between the last event and the idleTimeout, you can enable auto pings.

``` swift
// Ping is disabled by default
WTracker.shared.pingEnabled = true
```

To add custom visitor properties, you should edit the visitor object.

``` swift
WTracker.shared.visitor.add(property: "name", value: "John Smith")
WTracker.shared.visitor.add(property: "email", value: "john@smith.com")
```
Your custom visitor data will not be pushed until you send your first custom event. On website, the default event is a `pageview`. In mobile apps, we recommend that developers use the event `appview` when switching between Windows and Views.

To add send an `appview` event:

``` swift
// create event "appview"
let event = WEvent.event(name: "appview")
// add property "view" with value "login-view"
event.add(property: "view", value: "login-view")
// track event
WTracker.shared.trackEvent(event)
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
