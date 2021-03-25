// swift-tools-version:5.0

import PackageDescription

let package = Package(
  name: "TMDB",
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift.git", .exact("6.1.0"))
  ],
  targets: [
    .target(name: "TMDB", dependencies: ["RxSwift", "RxCocoa"])
  ]
)
