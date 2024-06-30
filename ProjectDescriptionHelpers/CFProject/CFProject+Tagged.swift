public extension CFProject {

    enum Tag {
        public enum Name { }
    }
    typealias Name = Tagged<Tag.Name, String>

}
