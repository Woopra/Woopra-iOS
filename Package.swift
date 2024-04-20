// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "WoopraSDK",
    products: [
        .library(
            name: "WoopraSDK",
            targets: ["WoopraSDK"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WoopraSDK",
            dependencies: [],
            path: "WoopraSDK"),
        .testTarget(
            name: "WoopraSDKTests",
            dependencies: ["WoopraSDK"],
            path: "WoopraSDKTests/Swift"),
    ],
    swiftLanguageVersions: [.v5]    
)