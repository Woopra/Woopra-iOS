// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "WoopraSDK",
    products: [
        .library(
            name: "Woopra",
            targets: ["Woopra"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Woopra",
            dependencies: [],
            path: "WoopraSDK"),
    ],
    swiftLanguageVersions: [.v5]    
)
