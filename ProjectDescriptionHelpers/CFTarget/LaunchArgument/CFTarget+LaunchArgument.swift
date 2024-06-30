import ProjectDescription

public extension CFTarget {

    struct LaunchArgument {

        public let name: Name
        public let isDefaultEnabled: IsDefaultEnabled

        public init(
            name: Name,
            isDefaultEnabled: IsDefaultEnabled
        ) {
            self.name = name
            self.isDefaultEnabled = isDefaultEnabled
        }

    }

}

public extension CFTarget.LaunchArgument {

    static let recordUISnapshots = Self.init(
        name: .recordUISnapshots,
        isDefaultEnabled: false
    )

}

public extension CFTarget.LaunchArgument {

    func toTuist() -> ProjectDescription.LaunchArgument {
        .launchArgument(
            name: name.toTuist(),
            isEnabled: isDefaultEnabled.toTuist()
        )
    }

}
