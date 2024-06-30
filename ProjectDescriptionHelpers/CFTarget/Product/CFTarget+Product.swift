import ProjectDescription

public extension CFTarget {

    enum Product {
        case app
        case framework
        case frameworkUnitTests
    }

}

public extension CFTarget.Product {

    func toTuist() -> Product {
        switch self {
        case .app:
            return .app
        case .framework:
            return .staticFramework
        case .frameworkUnitTests:
            return .unitTests
        }
    }

}
