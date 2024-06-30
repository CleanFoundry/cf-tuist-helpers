import ProjectDescription

public extension CFTarget {

    struct DeploymentTarget {

        public let iOS: iOS?
        public let tvOS: tvOS?

        public init(iOS: iOS?, tvOS: tvOS?) {
            self.iOS = iOS
            self.tvOS = tvOS
        }

    }

}

public extension CFTarget.DeploymentTarget {

    static func iOSDefault() -> Self {
        .init(
            iOS: .v17,
            tvOS: nil
        )
    }

    static func tvOSDefault() -> Self {
        .init(
            iOS: nil,
            tvOS: .v17_4
        )
    }

}

public extension CFTarget.DeploymentTarget {

    func toTuist() -> DeploymentTargets {
        .multiplatform(
            iOS: self.iOS?.toTuist(),
            tvOS: self.tvOS?.toTuist()
        )
    }

}
