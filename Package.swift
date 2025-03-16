// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetStatus",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "NetStatus",
            targets: ["NetStatus"]
        ),
    ],
    targets: [
        .target(
            name: "NetStatus",
            dependencies: []
        ),
        .testTarget(
            name: "NetStatusTests",
            dependencies: ["NetStatus"]
        ),
    ]
)
