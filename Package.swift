// swift-tools-version: 6.1
// GENERATED — do not edit by hand.
// Source of truth: BoundaryML/baml @ baml_language/sdks/swift/mirror/Package.swift
// Mirrored by the release pipeline (assemble-swift-sdk-mirror).
// Built from BoundaryML/baml @ bb1c02dc99e4712a9c09ad4605ca90e072768e21 (version 0.17.1-nightly.20260824.a).
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
            url: "https://github.com/BoundaryML/baml/releases/download/baml-language-0.17.1-nightly.20260824.a/BamlBridgeFFI-0.17.1-nightly.20260824.a.xcframework.zip",
            checksum: "da52ca3ac3384edfacdee7c7fb342ca955a71a2176121c079313b2d490900dea"
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
