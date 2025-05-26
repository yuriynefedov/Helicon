// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Helicon",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "HeliconFoundation",
            targets: ["HeliconFoundation"]
        ),
        .library(
            name: "HeliconUI",
            targets: ["HeliconUI"]
        ),
        .library(
            name: "HeliconFirebase",
            targets: ["HeliconFirebase"]
        ),
    ],
    targets: [
        .target(
            name: "HeliconFoundation"
        ),
        .target(
            name: "HeliconUI",
            dependencies: ["HeliconFoundation"]
        ),
        .target(
            name: "HeliconFirebase",
            dependencies: [
                "HeliconFoundation"
            ]
        )
    ]
)
