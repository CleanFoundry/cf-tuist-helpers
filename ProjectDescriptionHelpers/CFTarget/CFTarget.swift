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
