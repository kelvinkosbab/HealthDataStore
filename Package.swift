// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HealthDataStore",
    platforms: [
        .iOS(.v14),
        .macOS(.v12),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "HealthKitHelpers",
            targets: [
                "HealthKitHelpers"
            ]),
        
        .library(
            name: "HealthDataStore",
            targets: [
                "HealthDataStore"
            ]),
        
        .library(
            name: "CloudHealthDataStore",
            targets: [
                "CloudHealthDataStore"
            ]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(
            url: "https://github.com/kelvinkosbab/Core.git",
            branch: "main"
        )
    ],
    targets: [
        .target(
            name: "HealthKitHelpers",
            dependencies: [
                .product(name: "Core", package: "Core")
            ]),
        .testTarget(
            name: "HealthKitHelpersTests",
            dependencies: [
                "HealthKitHelpers"
            ]),
        
        .target(
            name: "HealthDataStore",
            dependencies: [
                .product(name: "CoreDataStore", package: "Core"),
                "HealthKitHelpers",
            ]),
        .testTarget(
            name: "HealthDataStoreTests",
            dependencies: [
                "HealthDataStore"
            ]),
        
        .target(
            name: "CloudHealthDataStore",
            dependencies: [
                "HealthDataStore",
                .product(name: "CoreDataStore", package: "Core")
            ]),
        .testTarget(
            name: "CloudHealthDataStoreTests",
            dependencies: [
                "CloudHealthDataStore"
            ]),
    ]
)
