<h2>Woopra iOS SDK Documentation</h2>

When the app loads, you should load the Woopra Tracker and configure it.

``` swift
WTracker.shared.domain = "mybusiness.com"
```

You can update your idle timeout (default: 30 seconds) by updating the timeout property in your WTracker instance:

``` swift
WTracker.shared.idleTimeout = 60
```

If you want to keep the user online on Woopra even if they don't commit any event between the last event and the idleTimeout, you can enable auto pings.

``` swift
// Ping is disabled by default
WTracker.shared.pingEnabled = true
```

To add custom visitor properties, you should edit the visitor object.

``` swift
WTracker.shared.visitor.add(property: "name", value: "John Smith")
WTracker.shared.visitor.add(property: "email" value: "john@smith.com")
```
Your custom visitor data will not be pushed until you send your first custom event. On website, the default event is a `pageview`. In mobile apps, we recommend that developers use the event `appview` when switching between Windows and Views.

To add send an `appview` event:

``` swift
// create event "appview"
let event = WEvent.event(name: "appview")
// add property "view" with value "login-view"
event.add(property: "view": value: "login-view")
// track event
WTracker.shared.trackEvent(event)
```
