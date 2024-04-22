// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Woopra",
    products: [
        .library(
            name: "Woopra",
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