import ProjectDescription

public extension CFTarget {

    enum Destination {
        case iPhone
        case iPad
        case tvOS
    }

}

public extension CFTarget.Destination {

    func toTuist() -> Destination {
        switch self {
        case .iPad:
            return .iPad
        case .iPhone:
            return .iPhone
        case .tvOS:
            return .appleTv
        }
    }

}
