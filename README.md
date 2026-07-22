# baml-swift

SwiftPM distribution of the [BAML](https://github.com/BoundaryML/baml) Swift
bridge: the `BamlBridge` runtime package plus the `BamlBridgeFFI` native
XCFramework (macOS arm64/x86_64, iOS device, iOS simulator).

> **Dev channel.** This repo is published automatically from the `canary`
> branch of the monorepo (rebuilds only when the Swift bridge, C ABI, wire
> protos, or version actually change). iOS slices compile and pass simulator
> tests but are not yet device-certified. Expect breaking changes between tags.

## Consuming

```swift
// Package.swift
.package(url: "https://github.com/BoundaryML/baml-swift", branch: "main")
// or pin an immutable tag:
.package(url: "https://github.com/BoundaryML/baml-swift", exact: "<tag>")
```

In Xcode: File → Add Package Dependencies → this URL → dependency rule
"Branch: main".

The package vends one library product, `BamlBridge`. Your app also needs a
**generated BAML SDK** (the typed `Baml.*` API for your `.baml` project) —
that is produced by the `baml` CLI, not shipped here:

```sh
# From a monorepo checkout at the EXACT commit in SOURCE_SHA:
cargo run -p baml_cli -- generate   # output_type = "swift" in baml.toml
```

Then add the generated `Sources/Baml` directory to your app target.

## The version handshake (read this before filing a crash)

At startup the generated SDK registers itself with the native runtime and
requires an **exact version match** (`register_bridge`). If the SDK you
generated and the binary this package vends come from different monorepo
commits with different versions, your app will `fatalError` at first call
— by design. Always regenerate your SDK from the commit in
[`SOURCE_SHA`](SOURCE_SHA) after bumping this package.

## How this repo is published

Nobody edits this repo by hand. The
[`publish`](.github/workflows/publish.yml) workflow:

1. Polls (and can be manually dispatched for) the head of
   `BoundaryML/baml@canary`.
2. Checks out the monorepo at that SHA and builds all five Apple slices via
   `sdks/swift/scripts/build-xcframework.sh --all`
   (`release-bridge-swift` profile: panic=unwind, caught at the ABI
   boundary).
3. Zips the XCFramework, uploads it as an **immutable** GitHub Release
   asset tagged `dev-<version>-<shortsha>`, and computes the SwiftPM
   checksum.
4. Regenerates this repo's tree: `Sources/BamlBridge` copied verbatim from
   the monorepo, `Package.swift` stamped with the release URL + checksum,
   `SOURCE_SHA` updated. One commit per publish.

Release assets are never overwritten; rolling back is reverting one commit
on `main`.
