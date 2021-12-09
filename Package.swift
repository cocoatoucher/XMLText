// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XMLText",
    platforms: [
        .iOS(.v15), .macOS(.v12), .tvOS(.v14), .watchOS(.v7)
    ],
    products: [
        .library(
            name: "XMLText",
            targets: ["XMLText"]
        ),
    ],
    targets: [
        .target(
            name: "XMLText",
            path: "Sources"
        ),
        .testTarget(
            name: "XMLTextTests",
            dependencies: ["XMLText"]
        ),
    ]
)
