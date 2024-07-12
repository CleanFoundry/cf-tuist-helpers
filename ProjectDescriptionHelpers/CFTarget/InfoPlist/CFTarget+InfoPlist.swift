import ProjectDescription

public extension CFTarget {

    enum InfoPlist: Sendable {

        case `default`
        case extendingDefault([String: ProjectDescription.Plist.Value])

    }

}

public extension CFTarget.InfoPlist {

    func toTuist() -> ProjectDescription.InfoPlist {
        switch self {
        case .default: return .default
        case let .extendingDefault(values): return .extendingDefault(with: values)
        }
    }

}
