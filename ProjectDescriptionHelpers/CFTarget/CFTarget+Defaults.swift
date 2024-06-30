import ProjectDescription

public extension CFTarget {

    struct Default {

        static func app(
            name: Name,
            destinations: Set<Destination>,
            infoPlist: InfoPlist,
            internalDependencies: [CFTarget.Name],
            externalDependencies: [CFExternalTargetName],
            deploymentTarget: DeploymentTarget,
            settings: SettingsDictionary = [:],
            launchArguments: [LaunchArgument] = []
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

        static func framework(
            name: Name,
            destinations: Set<Destination>,
            internalDependencies: [CFTarget.Name],
            externalDependencies: [CFExternalTargetName],
            deploymentTarget: DeploymentTarget,
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

        static func frameworkUnitTest(
            testing target: CFTarget,
            internalDependencies: [CFTarget.Name],
            externalDependencies: [CFExternalTargetName],
            deploymentTarget: DeploymentTarget
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
    static let `default` = Default()

}
