// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "pr-tool",
    products: [
        .executable(name: "pr-tool", targets: ["PrTool"]),
    ],
    dependencies: [
         .package(url: "https://github.com/Einstore/GitHubKit.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "PrTool",
            dependencies: [
                "GitHubKit"
            ]
        )
    ]
)

