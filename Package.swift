// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Woopra_iOS",
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