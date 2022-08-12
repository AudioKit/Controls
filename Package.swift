// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "DraggableControl",
    products: [.library(name: "DraggableControl",
                        targets: ["DraggableControl"])],
    targets: [
        .target(name: "DraggableControl", dependencies: []),
        .testTarget(name: "DraggableControlTests", dependencies: ["DraggableControl"]),
    ]
)
