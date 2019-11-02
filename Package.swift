// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftForm",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "SwiftForm",
            targets: ["SwiftForm"]),
    ],
    targets: [
        .target(
            name: "SwiftForm",
            dependencies: [],
            path: "SwiftForm"),
        .testTarget(
            name: "SwiftFormTests",
            dependencies: ["SwiftForm"],
            path: "SwiftFormTests"),
    ],
    swiftLanguageVersions: [.v4_2, .v5]
)
