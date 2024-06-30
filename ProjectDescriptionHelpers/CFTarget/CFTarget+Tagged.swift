public extension CFTarget {

    enum Tag {
        public enum Name { }
        public enum DeploymentTargetiOS { }
    }
    typealias Name = Tagged<Tag.Name, String>

}

public extension CFTarget.Name {

    static func testing(targetName: CFTarget.Name) -> Self {
        "\(targetName)Tests"
    }

}
