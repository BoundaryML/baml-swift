// swift-tools-version: 6.1
// GENERATED — do not edit by hand.
// Source of truth: BoundaryML/baml @ baml_language/sdks/swift/mirror/Package.swift
// Mirrored by the release pipeline (assemble-swift-sdk-mirror).
// Built from BoundaryML/baml @ 0bb3b9fe6f0b81c9085787f6fad481789a5c381b (version 0.25.3-nightly.20261115.a).
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
            url: "https://github.com/BoundaryML/baml/releases/download/baml-language-0.25.3-nightly.20261115.a/BamlBridgeFFI-0.25.3-nightly.20261115.a.xcframework.zip",
            checksum: "50d2a86a24114eea0529dc0314426d75b78aebebec7df73a65469b216bd9c3e0"
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
