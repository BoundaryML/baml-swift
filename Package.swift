// swift-tools-version: 6.1
// GENERATED — do not edit by hand.
// Source of truth: BoundaryML/baml @ baml_language/sdks/swift/mirror/Package.swift
// Mirrored by the release pipeline (assemble-swift-sdk-mirror).
// Built from BoundaryML/baml @ 8f1fa6f00e932e06b8ecd526c7025226ad1cfe77 (version 0.15.1-nightly.20260730.d).
import PackageDescription

let package = Package(
    name: "baml-swift",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
    ],
    products: [
        .library(name: "BamlBridge", targets: ["BamlBridge"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.38.0")
    ],
    targets: [
        .binaryTarget(
            name: "BamlBridgeFFI",
            url: "https://github.com/BoundaryML/baml/releases/download/baml-language-0.15.1-nightly.20260730.d/BamlBridgeFFI-0.15.1-nightly.20260730.d.xcframework.zip",
            checksum: "099994dd892e317e41600c8813b5c28f73453f37b8ef5ff0c1ff6edb5008b221"
        ),
        .target(
            name: "BamlBridge",
            dependencies: [
                "BamlBridgeFFI",
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
            ],
            linkerSettings: [
                // System deps of the Rust staticlib (TLS roots, DNS, CF).
                .linkedFramework("CoreFoundation"),
                .linkedFramework("Security"),
                .linkedFramework("SystemConfiguration"),
                .linkedLibrary("resolv"),
            ]
        ),
    ]
)
