// Tuist Plugins don’t support bringing in third-party code.
// This source is copied and trimmed down from the swift-tagged repo @ varion 0.10.0.

@dynamicMemberLookup
public struct Tagged<Tag, RawValue> {
    public var rawValue: RawValue

    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }

    public init(_ rawValue: RawValue) {
        self.rawValue = rawValue
    }

    public func map<B>(_ f: (RawValue) -> B) -> Tagged<Tag, B> {
        return .init(rawValue: f(self.rawValue))
    }
}

extension Tagged {
    public subscript<T>(dynamicMember keyPath: KeyPath<RawValue, T>) -> T {
        return self.rawValue[keyPath: keyPath]
    }
}

extension Tagged: CustomStringConvertible {
    public var description: String {
        return String(describing: self.rawValue)
    }
}

extension Tagged: RawRepresentable {}

extension Tagged: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        return self.rawValue
    }
}

// MARK: - Conditional Conformances

extension Tagged: Comparable where RawValue: Comparable {
    public static func < (lhs: Tagged, rhs: Tagged) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

extension Tagged: Decodable where RawValue: Decodable {
    public init(from decoder: Decoder) throws {
        do {
            self.init(rawValue: try decoder.singleValueContainer().decode(RawValue.self))
        } catch {
            self.init(rawValue: try .init(from: decoder))
        }
    }
}

extension Tagged: Encodable where RawValue: Encodable {
    public func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.singleValueContainer()
            try container.encode(self.rawValue)
        } catch {
            try self.rawValue.encode(to: encoder)
        }
    }
}

#if swift(>=5.6)
@available(macOS 12.3, iOS 15.4, watchOS 8.5, tvOS 15.4, *)
extension Tagged: CodingKeyRepresentable where RawValue: CodingKeyRepresentable {
    public init?<T: CodingKey>(codingKey: T) {
        guard let rawValue = RawValue(codingKey: codingKey)
        else { return nil }
        self.init(rawValue: rawValue)
    }

    public var codingKey: CodingKey {
        self.rawValue.codingKey
    }
}
#endif

extension Tagged: Equatable where RawValue: Equatable {}

extension Tagged: Error where RawValue: Error {}

#if canImport(_Concurrency) && compiler(>=5.5.2)
extension Tagged: Sendable where RawValue: Sendable {}
#endif

#if canImport(Foundation)
import Foundation
extension Tagged: LocalizedError where RawValue: Error {
    public var errorDescription: String? {
        return rawValue.localizedDescription
    }
    public var failureReason: String? {
        return (rawValue as? LocalizedError)?.failureReason
    }
    public var helpAnchor: String? {
        return (rawValue as? LocalizedError)?.helpAnchor
    }
    public var recoverySuggestion: String? {
        return (rawValue as? LocalizedError)?.recoverySuggestion
    }
}
#endif

extension Tagged: ExpressibleByBooleanLiteral where RawValue: ExpressibleByBooleanLiteral {
    public typealias BooleanLiteralType = RawValue.BooleanLiteralType

    public init(booleanLiteral value: RawValue.BooleanLiteralType) {
        self.init(rawValue: RawValue(booleanLiteral: value))
    }
}

extension Tagged: ExpressibleByExtendedGraphemeClusterLiteral where RawValue: ExpressibleByExtendedGraphemeClusterLiteral {
    public typealias ExtendedGraphemeClusterLiteralType = RawValue.ExtendedGraphemeClusterLiteralType

    public init(extendedGraphemeClusterLiteral: ExtendedGraphemeClusterLiteralType) {
        self.init(rawValue: RawValue(extendedGraphemeClusterLiteral: extendedGraphemeClusterLiteral))
    }
}

extension Tagged: ExpressibleByIntegerLiteral where RawValue: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = RawValue.IntegerLiteralType

    public init(integerLiteral: IntegerLiteralType) {
        self.init(rawValue: RawValue(integerLiteral: integerLiteral))
    }
}

extension Tagged: ExpressibleByStringLiteral where RawValue: ExpressibleByStringLiteral {
    public typealias StringLiteralType = RawValue.StringLiteralType

    public init(stringLiteral: StringLiteralType) {
        self.init(rawValue: RawValue(stringLiteral: stringLiteral))
    }
}

extension Tagged: ExpressibleByStringInterpolation where RawValue: ExpressibleByStringInterpolation {
    public typealias StringInterpolation = RawValue.StringInterpolation

    public init(stringInterpolation: Self.StringInterpolation) {
        self.init(rawValue: RawValue(stringInterpolation: stringInterpolation))
    }
}

extension Tagged: ExpressibleByUnicodeScalarLiteral where RawValue: ExpressibleByUnicodeScalarLiteral {
    public typealias UnicodeScalarLiteralType = RawValue.UnicodeScalarLiteralType

    public init(unicodeScalarLiteral: UnicodeScalarLiteralType) {
        self.init(rawValue: RawValue(unicodeScalarLiteral: unicodeScalarLiteral))
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Tagged: Identifiable where RawValue: Identifiable {
    public typealias ID = RawValue.ID

    public var id: ID {
        return rawValue.id
    }
}

extension Tagged: LosslessStringConvertible where RawValue: LosslessStringConvertible {
    public init?(_ description: String) {
        guard let rawValue = RawValue(description) else { return nil }
        self.init(rawValue: rawValue)
    }
}

extension Tagged: AdditiveArithmetic where RawValue: AdditiveArithmetic {
    public static var zero: Tagged {
        return self.init(rawValue: .zero)
    }

    public static func + (lhs: Tagged, rhs: Tagged) -> Tagged {
        return self.init(rawValue: lhs.rawValue + rhs.rawValue)
    }

    public static func += (lhs: inout Tagged, rhs: Tagged) {
        lhs.rawValue += rhs.rawValue
    }

    public static func - (lhs: Tagged, rhs: Tagged) -> Tagged {
        return self.init(rawValue: lhs.rawValue - rhs.rawValue)
    }

    public static func -= (lhs: inout Tagged, rhs: Tagged) {
        lhs.rawValue -= rhs.rawValue
    }
}

extension Tagged: Numeric where RawValue: Numeric {
    public init?<T>(exactly source: T) where T: BinaryInteger {
        guard let rawValue = RawValue(exactly: source) else { return nil }
        self.init(rawValue: rawValue)
    }

    public var magnitude: RawValue.Magnitude {
        return self.rawValue.magnitude
    }

    public static func * (lhs: Tagged, rhs: Tagged) -> Tagged {
        return self.init(rawValue: lhs.rawValue * rhs.rawValue)
    }

    public static func *= (lhs: inout Tagged, rhs: Tagged) {
        lhs.rawValue *= rhs.rawValue
    }
}

extension Tagged: Hashable where RawValue: Hashable {}

public enum Tag { }

public extension Tagged {
    func toTuist() -> RawValue {
        rawValue
    }
}
