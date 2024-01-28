// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Controls",
    platforms: [.macOS(.v12), .iOS(.v15), .visionOS(.v1)],
    products: [.library(name: "Controls", targets: ["Controls"])],
    targets: [
        .target(name: "Controls", dependencies: []),
        .testTarget(name: "ControlsTests", dependencies: ["Controls"]),
    ]
)
