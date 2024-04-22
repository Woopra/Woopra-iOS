// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "WoopraSDK",
    products: [
        .library(
            name: "Woopra_iOS",
            targets: ["WoopraSDK"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WoopraSDK",
            dependencies: [],
            path: "WoopraSDK"),
    ],
    swiftLanguageVersions: [.v5]    
)