//
//  Package.swift
//  ASDS_CLUB
//
//  Created by Nurkhan Tashimov on 14.12.2023.
//

import PackageDescription

let package = Package(
    name: "ASDS_CLUB",
    platforms: [
        .macOS(.v12),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        // Другие ваши зависимости
    ],
    targets: [
        .target(
            name: "ASDS_CLUB",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                // Другие ваши зависимости
            ]
        ),
        .testTarget(
            name: "ASDS_CLUB_TESTS",
            dependencies: ["ASDS_CLUB"]
        ),
    ]
)
