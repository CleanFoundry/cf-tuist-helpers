import ProjectDescription

public struct CFTarget {

    public let name: Name
    public let destinations: Set<Destination>
    public let product: Product
    public let bundleID: CFBundleID
    public let deploymentTarget: DeploymentTarget
    public let infoPlist: InfoPlist
    public let sourcePaths: [CFFilePath]
    public let resourcePaths: [CFFilePath]
    public let internalDependencies: [CFTarget.Name]
    public let externalDependencies: [CFExternalTargetName]
    public let settings: ProjectDescription.SettingsDictionary
    public let launchArguments: [LaunchArgument]

    public init(
        name: Name,
        destinations: Set<Destination>,
        product: Product,
        bundleID: CFBundleID,
        deploymentTarget: DeploymentTarget,
        infoPlist: InfoPlist,
        sourcePaths: [CFFilePath],
        resourcePaths: [CFFilePath],
        internalDependencies: [CFTarget.Name],
        externalDependencies: [CFExternalTargetName],
        settings: ProjectDescription.SettingsDictionary,
        launchArguments: [LaunchArgument]
    ) {
        self.name = name
        self.destinations = destinations
        self.product = product
        self.bundleID = bundleID
        self.deploymentTarget = deploymentTarget
        self.infoPlist = infoPlist
        self.sourcePaths = sourcePaths
        self.resourcePaths = resourcePaths
        self.internalDependencies = internalDependencies
        self.externalDependencies = externalDependencies
        self.settings = settings
        self.launchArguments = launchArguments
    }

}

public extension CFTarget {

    static func defaultApp(
        name: Name,
        destinations: Set<Destination>,
        infoPlist: InfoPlist,
        internalDependencies: [CFTarget.Name],
        externalDependencies: [CFExternalTargetName],
        deploymentTarget: DeploymentTarget,
        settings: SettingsDictionary = [:],
        launchArguments: [LaunchArgument] = []
    ) -> Self {
        Self.init(
            name: name,
            destinations: destinations,
            product: .app,
            bundleID: .default(targetName: name),
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sourcePaths: [
                .sources(targetName: name)
            ],
            resourcePaths: [
                .resources(targetName: name)
            ],
            internalDependencies: internalDependencies,
            externalDependencies: externalDependencies,
            settings: settings,
            launchArguments: launchArguments
        )
    }

    static func defaultFramework(
        name: Name,
        destinations: Set<Destination>,
        internalDependencies: [CFTarget.Name],
        externalDependencies: [CFExternalTargetName],
        deploymentTarget: DeploymentTarget,
        includeResources: Bool = false
    ) -> Self {
        Self.init(
            name: name,
            destinations: destinations,
            product: .framework,
            bundleID: .default(targetName: name),
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sourcePaths: [
                .sources(targetName: name),
            ],
            resourcePaths: includeResources ? [
                .resources(targetName: name)
            ] : [],
            internalDependencies: internalDependencies,
            externalDependencies: externalDependencies,
            settings: [:],
            launchArguments: []
        )
    }

    static func defaultFrameworkUnitTests(
        testing target: CFTarget,
        internalDependencies: [CFTarget.Name],
        externalDependencies: [CFExternalTargetName],
        deploymentTarget: DeploymentTarget
    ) -> Self {
        let name: CFTarget.Name = .testing(targetName: target.name)
        return Self.init(
            name: name,
            destinations: target.destinations,
            product: .frameworkUnitTests,
            bundleID: .default(targetName: name),
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sourcePaths: [
                .tests(testTargetName: name),
            ],
            resourcePaths: [],
            internalDependencies: internalDependencies + [target.name],
            externalDependencies: externalDependencies,
            settings: [:],
            launchArguments: [
                .recordUISnapshots,
            ]
        )
    }

}


public extension CFTarget {

    func toTuist() -> Target {
        Target.target(
            name: name.toTuist(),
            destinations: Set(destinations.map {
                $0.toTuist()
            }),
            product: product.toTuist(),
            bundleId: bundleID.toTuist(),
            deploymentTargets: deploymentTarget.toTuist(),
            infoPlist: infoPlist.toTuist(),
            sources: .paths(sourcePaths.map {
                .path($0.toTuist())
            }),
            resources: .resources(resourcePaths.map {
                .glob(pattern: .path($0.toTuist()))
            }),
            dependencies: internalDependencies.map {
                .target(name: $0.toTuist())
            } + externalDependencies.map {
                .external(name: $0.toTuist())
            },
            settings: .settings(base: settings),
            launchArguments: launchArguments.map {
                $0.toTuist()
            }
        )
    }

}
