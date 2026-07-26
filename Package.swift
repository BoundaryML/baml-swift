// swift-tools-version: 6.1
// GENERATED — do not edit by hand.
// Source of truth: BoundaryML/baml @ baml_language/sdks/swift/mirror/Package.swift
// Mirrored by the release pipeline (assemble-swift-sdk-mirror).
// Built from BoundaryML/baml @ 78cee609928d907380e68af20a8a47707dc37901 (version 0.15.1-nightly.20260726.a).
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
            url: "https://github.com/BoundaryML/baml/releases/download/baml-language-0.15.1-nightly.20260726.a/BamlBridgeFFI-0.15.1-nightly.20260726.a.xcframework.zip",
            checksum: "435fcf7052dcaf39edfebac15f769176a3861f8759239dac6928e6b4abac2ed6"
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
