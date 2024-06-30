public extension Tag {

    enum CFOrganizationName { }
    typealias OrganizationName = Tagged<Tag.CFOrganizationName, String>

}

public typealias CFOrganizationName = Tagged<Tag.CFOrganizationName, String>

public extension CFOrganizationName {

    static let cleanFoundry: Self = "CleanFoundry"

}
