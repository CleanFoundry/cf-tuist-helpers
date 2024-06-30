public extension Tag {
    enum CFBundleID { }
}

public typealias CFBundleID = Tagged<Tag.CFBundleID, String>

public extension CFBundleID {

    static func `default`(
        targetName: CFTarget.Name
    ) -> Self {
        "com.\(CFOrganizationName.cleanFoundry).\(targetName)"
    }

}
