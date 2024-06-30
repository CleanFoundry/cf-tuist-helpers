public extension Tag {
    enum CFFilePath { }
}

public typealias CFFilePath = Tagged<Tag.CFFilePath, String>

public extension CFFilePath {

    static func sources(
        targetName: CFTarget.Name
    ) -> Self {
        "Sources/\(targetName)/**"
    }

    static func resources(
        targetName: CFTarget.Name
    ) -> Self {
        "Resources/\(targetName)/**"
    }

    static func tests(
        testTargetName: CFTarget.Name
    ) -> Self {
        "Tests/\(testTargetName)/**"
    }

}
