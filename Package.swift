// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIAnimationObserver",
    platforms: [
      .iOS(.v13), .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "SwiftUIAnimationObserver",
            targets: ["SwiftUIAnimationObserver"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftUIAnimationObserver",
            dependencies: []),
        .testTarget(
            name: "SwiftUIAnimationObserverTests",
            dependencies: ["SwiftUIAnimationObserver"]),
    ]
)
