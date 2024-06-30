import ProjectDescription

public struct CFProject {

    public let name: Name
    public let organizationName: CFOrganizationName
    public let options: Options
    public let targets: [CFTarget]
    public let additionalFiles: [CFFilePath]

    public init(
        name: Name,
        organizationName: CFOrganizationName,
        options: Options,
        targets: [CFTarget],
        additionalFiles: [CFFilePath]
    ) {
        self.name = name
        self.organizationName = organizationName
        self.options = options
        self.targets = targets
        self.additionalFiles = additionalFiles
    }

}

public extension CFProject {

    static func `default`(
        name: Name,
        targets: [CFTarget],
        additionalFiles: [CFFilePath]
    ) -> Self {
        CFProject(
            name: name,
            organizationName: .cleanFoundry,
            options: .default,
            targets: targets,
            additionalFiles: additionalFiles
        )
    }

}

public extension CFProject {

    func toTuist() -> Project {
        Project(
            name: name.rawValue,
            organizationName: organizationName.rawValue,
            options: options.toTuist(),
            targets: targets.map { $0.toTuist() },
            additionalFiles: additionalFiles.map {
                .glob(pattern: .path($0.toTuist()))
            }
        )
    }

}
