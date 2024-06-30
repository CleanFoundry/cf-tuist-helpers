import ProjectDescription

public extension CFTarget.LaunchArgument {

    enum Tag {
        public enum Name { }
        public enum IsDefaultEnabled { }
    }
    typealias Name = Tagged<Tag.Name, String>
    typealias IsDefaultEnabled = Tagged<Tag.IsDefaultEnabled, Bool>

}

public extension CFTarget.LaunchArgument.Name {

    static let recordUISnapshots: Self = "RECORD_UI_SNAPSHOTS"

}
