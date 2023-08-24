# ``Spezi/Standard``

<!--

This source file is part of the Stanford Spezi open-source project

SPDX-FileCopyrightText: 2023 Stanford University and the project authors (see CONTRIBUTORS.md)

SPDX-License-Identifier: MIT

-->

@Metadata {
    @DocumentationExtension(mergeBehavior: append)
}

Components can use the constraint mechanism to enforce a set of requirements to the ``Standard`` used in the Spezi-based software where the component is used.
This mechanism follows a two-step process detailed in the component documentation: ``Component``.

The constraints are defined using a protocol that conforms to the `Standard` protocol:

```swift
protocol ExampleConstraint: Standard {
    // ...
}
```

You will have to define your own ``Standard`` type or use a predefined one that either conforms to all requirements or is extended to support these requirements using Swift extensions if your application uses any components that enforce constraints on the ``Standard`` instance.

#### 1. Standard Conformance 

The `Standard` defined in the `Configuration` must conform to all constraints defined by `Components` using their `@StandardActor`s, or you need to write an extension to an existing `Standard` that you use to implement the conformance.

If you define your own standard, you can define the conformance and complete implementation in your code:
```swift
actor ExampleStandard: Standard, ExampleConstraint {
    // ...
}
```

If you use a predefined standard, you can extend it using Swift extensions if it does not yet support the required component constraints.
```swift
extension ExistingStandard: ExampleConstraint {
    // ...
}
```

#### 2. Standard Definition 

The standard as well as all components, are defined using the ``Configuration`` in the app delegate conforming to ``SpeziAppDelegate``.
Ensure that you define an appropriate standard in your configuration in your `SpeziAppDelegate` subclass:

```swift
var configuration: Configuration {
    Configuration(standard: ExampleStandard()) {
        // ...
    }
}
```

> Note: You can learn more about setting up your application in the <doc:Initial-Setup> article. You can learn more about the ``Configuration`` in its type documentation.

You can always access the current ``Standard`` instance in your ``Component`` using the @``Component/StandardActor`` property wrapper.
It is also available using the `@EnvironmentObject` property wrapper in your SwiftUI views.
