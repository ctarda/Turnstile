import PackageDescription

let package = Package(
    name: "Turnstile",
    targets: [
        Target(name: "TurnstileTests", dependencies: [.Target(name: "Turnstile")])
    ]
)
