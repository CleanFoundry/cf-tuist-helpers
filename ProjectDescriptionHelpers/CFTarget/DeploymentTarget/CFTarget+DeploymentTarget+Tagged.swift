import ProjectDescription

public extension CFTarget.DeploymentTarget {

    enum Tag {
        public enum iOS { }
        public enum tvOS { }
    }
    typealias iOS = Tagged<Tag.iOS, String>
    typealias tvOS = Tagged<Tag.tvOS, String>

}

public extension CFTarget.DeploymentTarget.iOS {

    static let v17: Self = "17.0"

}

public extension CFTarget.DeploymentTarget.tvOS {

    static let v17_5_1: Self = "17.5.1"

}
