//
// This source file is part of the CardinalKit open-source project
//
// SPDX-FileCopyrightText: 2022 CardinalKit and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// A function builder used to aggregate multiple `Component`s
@resultBuilder
public enum ComponentBuilder<S: Standard> {
    /// If declared, provides contextual type information for statement expressions to translate them into partial results.
    public static func buildExpression<C: Component>(_ expression: C) -> [any Component<S>] where C.ComponentStandard == S {
        [expression]
    }
    
    /// Required by every result builder to build combined results from statement blocks.
    public static func buildBlock(_ components: [any Component<S>]...) -> [any Component<S>] {
        components.flatMap { $0 }
    }
    
    /// Enables support for `if` statements that do not have an `else`.
    public static func buildOptional(_ component: [any Component<S>]?) -> [any Component<S>] {
        // swiftlint:disable:previous discouraged_optional_collection
        // The optional collection is a requirement defined by @resultBuilder, we can not use a non-optional collection here.
        component ?? []
    }

    /// With buildEither(second:), enables support for 'if-else' and 'switch' statements by folding conditional results into a single result.
    public static func buildEither(first: [any Component<S>]) -> [any Component<S>] {
        first
    }
    
    /// With buildEither(first:), enables support for 'if-else' and 'switch' statements by folding conditional results into a single result.
    public static func buildEither(second: [any Component<S>]) -> [any Component<S>] {
        second
    }
    
    /// Enables support for 'for..in' loops by combining the results of all iterations into a single result.
    public static func buildArray(_ components: [[any Component<S>]]) -> [any Component<S>] {
        components.flatMap { $0 }
    }
    
    /// If declared, this will be called on the partial result of an 'if #available' block to allow the result builder to erase type information.
    public static func buildLimitedAvailability(_ component: [any Component<S>]) -> [any Component<S>] {
        component
    }
    
    /// If declared, this will be called on the partial result from the outermost block statement to produce the final returned result.
    public static func buildFinalResult(_ component: [any Component<S>]) -> ComponentCollection<S> {
        ComponentCollection(elements: component)
    }
}
