public extension CFWorkspace {

    enum Tag {
        public enum Name { }
    }
    typealias Name = Tagged<Tag.Name, String>

}
