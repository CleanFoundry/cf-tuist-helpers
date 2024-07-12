import ProjectDescription

public extension CFTarget {

    struct Default: Sendable {
        fileprivate init() { }
    }
    static let `default` = Default()

}

public extension CFTarget.Default {

    func app(
        name: CFTarget.Name,
        destinations: Set<CFTarget.Destination>,
        infoPlist: CFTarget.InfoPlist,
        internalDependencies: [CFTarget.Name],
        externalDependencies: [CFExternalTargetName],
        deploymentTarget: CFTarget.DeploymentTarget,
        settings: SettingsDictionary = [:],
        launchArguments: [CFTarget.LaunchArgument] = []
    ) -> CFTarget {
        CFTarget(
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

    func framework(
        name: CFTarget.Name,
        destinations: Set<CFTarget.Destination>,
        internalDependencies: [CFTarget.Name],
        externalDependencies: [CFExternalTargetName],
        deploymentTarget: CFTarget.DeploymentTarget,
        includeResources: Bool = false
    ) -> CFTarget {
        CFTarget(
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

    func frameworkUnitTest(
        testing target: CFTarget,
        internalDependencies: [CFTarget.Name],
        externalDependencies: [CFExternalTargetName],
        deploymentTarget: CFTarget.DeploymentTarget
    ) -> CFTarget {
        let name: CFTarget.Name = .testing(targetName: target.name)
        return CFTarget(
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
