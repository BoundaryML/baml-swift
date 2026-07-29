// swift-tools-version: 6.1
// GENERATED — do not edit by hand.
// Source of truth: BoundaryML/baml @ baml_language/sdks/swift/mirror/Package.swift
// Mirrored by the release pipeline (assemble-swift-sdk-mirror).
// Built from BoundaryML/baml @ 2d8da0cd1b9ec490765bbb29834ddd9b01a6b5ea (version 0.15.1-nightly.20260729.b).
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
            url: "https://github.com/BoundaryML/baml/releases/download/baml-language-0.15.1-nightly.20260729.b/BamlBridgeFFI-0.15.1-nightly.20260729.b.xcframework.zip",
            checksum: "b4307139c261ef481cd517a353737155ea65d29af18c5f70bac96945ecd50d71"
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
