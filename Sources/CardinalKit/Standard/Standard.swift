//
// This source file is part of the CardinalKit open-source project
//
// SPDX-FileCopyrightText: 2022 CardinalKit and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


/// A ``Standard`` defines a common representation of resources using by different `CardinalKit` components.
public protocol Standard: Actor, Component where ComponentStandard == Self { }
