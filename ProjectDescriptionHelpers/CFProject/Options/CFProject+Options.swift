import ProjectDescription

public extension CFProject {

    struct Options: Sendable {

        public struct SuffixGroups: Sendable {

            public let test: Set<String>
            public let run: Set<String>

            public init(test: Set<String>, run: Set<String>) {
                self.test = test
                self.run = run
            }

        }
        public let suffixGroups: SuffixGroups
        public let codeCoverageEnabled: Bool

        public init(suffixGroups: SuffixGroups, codeCoverageEnabled: Bool) {
            self.suffixGroups = suffixGroups
            self.codeCoverageEnabled = codeCoverageEnabled
        }

    }

}

public extension CFProject.Options {

    static let `default` = Self.init(
        suffixGroups: .init(
            test: ["Tests"],
            run: ["App"]
        ),
        codeCoverageEnabled: true
    )

}

public extension CFProject.Options {

    func toTuist() -> Project.Options {
        .options(
            automaticSchemesOptions: .enabled(
                targetSchemesGrouping: .byNameSuffix(
                    build: [],
                    test: suffixGroups.test,
                    run: suffixGroups.run
                ),
                codeCoverageEnabled: codeCoverageEnabled
            )
        )
    }

}
