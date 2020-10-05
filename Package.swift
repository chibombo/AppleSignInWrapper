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
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "AppleIDButtonWrapper",
            targets: ["AppleIDButtonWrapper"])
    ],
    dependencies: [
    ],
    targets: [

        .target(
            name: "AppleIDButtonWrapper",
            dependencies: []),
        .testTarget(
            name: "AppleIDButtonWrapperTests",
            dependencies: ["AppleIDButtonWrapper"])
    ]
)
