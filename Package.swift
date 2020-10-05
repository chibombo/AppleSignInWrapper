// swift-tools-version:5.3
//
//  Package.swift
//  AppleIDButtonWrapper
//
//  Created by Genaro Arvizu on 04/10/20.
//  Copyright © 2020 Luis Genaro Arvizu Vega. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "AppleIDButtonWrapper",
    platforms: [.iOS(.v13),
                 .macOS(.v10_15)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "AppleIDButtonWrapper",
            targets: ["AppleIDButtonWrapper"])
    ],
    targets: [

        .target(
            name: "AppleIDButtonWrapper",
            path: "Sources"),
        .testTarget(
            name: "AppleIDButtonWrapperTests",
            dependencies: ["AppleIDButtonWrapper"])
    ]
)
