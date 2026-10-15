// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LigerZero",
    dependencies: [
        .package(url: "https://github.com/tonytins/motive-engine.git", branch: "main"),
    ],
    targets: [
        .executableTarget(
            name: "LigerZero",
            dependencies: [
                .product(name: "MotiveEngine", package: "motive-engine"),
            ],
            resources: [
                .copy("Content"),
                .copy("lot.json"),
            ]
        ),
        .testTarget(
            name: "LigerZeroTests",
            dependencies: ["LigerZero"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
