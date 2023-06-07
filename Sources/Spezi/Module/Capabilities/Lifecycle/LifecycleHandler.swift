//
// This source file is part of the Stanford Spezi open-source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import os
import SwiftUI


/// Delegate methods are related to the  `UIApplication` and ``Spezi/Spezi`` lifecycle.
///
/// Conform to the `LifecycleHandler` protocol to get updates about the application lifecycle similar to the `UIApplicationDelegate` on an app basis.
public protocol LifecycleHandler {
    /// Replicates  the `application(_: UIApplication, willFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool`
    /// functionality of the `UIApplicationDelegate`.
    ///
    /// Tells the delegate that the launch process has begun but that state restoration hasn’t occured.
    /// - Parameters:
    ///   - application: The singleton app object.
    ///   - launchOptions: A dictionary indicating the reason the app was launched (if any). The contents of this dictionary may be empty in situations where the user launched the app directly. For information about the possible keys in this dictionary and how to handle them, see UIApplication.LaunchOptionsKey.
    func willFinishLaunchingWithOptions(
        _ application: UIApplication,
        launchOptions: [UIApplication.LaunchOptionsKey: Any]
    )
    
    /// Replicates  the `applicationDidBecomeActive(_: UIApplication)` functionality of the `UIApplicationDelegate`.
    ///
    /// Tells the delegate that the app has become active.
    /// - Parameter application: Your singleton app object.
    func applicationDidBecomeActive(_ application: UIApplication)
    
    /// Replicates  the `applicationWillResignActive(_: UIApplication)` functionality of the `UIApplicationDelegate`.
    ///
    /// Tells the delegate that the app is about to become inactive.
    /// - Parameter application: Your singleton app object.
    func applicationWillResignActive(_ application: UIApplication)
    
    /// Replicates  the `applicationDidEnterBackground(_: UIApplication)` functionality of the `UIApplicationDelegate`.
    ///
    /// Tells the delegate that the app is now in the background.
    /// - Parameter application: Your singleton app object.
    func applicationDidEnterBackground(_ application: UIApplication)
    
    /// Replicates  the `applicationWillEnterForeground(_: UIApplication)` functionality of the `UIApplicationDelegate`.
    ///
    /// Tells the delegate that the app is about to enter the foreground.
    /// - Parameter application: Your singleton app object.
    func applicationWillEnterForeground(_ application: UIApplication)
    
    /// Replicates  the `applicationWillTerminate(_: UIApplication)` functionality of the `UIApplicationDelegate`.
    ///
    /// Tells the delegate when the app is about to terminate.
    /// - Parameter application: Your singleton app object.
    func applicationWillTerminate(
        _ application: UIApplication
    )
}


extension LifecycleHandler {
    // A documentation for this methodd exists in the `LifecycleHandler` type which SwiftLint doesn't recognize.
    // swiftlint:disable:next missing_docs
    public func willFinishLaunchingWithOptions(
        _ application: UIApplication,
        launchOptions: [UIApplication.LaunchOptionsKey: Any]
    ) { }
    
    // A documentation for this methodd exists in the `LifecycleHandler` type which SwiftLint doesn't recognize.
    // swiftlint:disable:next missing_docs
    public func applicationDidBecomeActive(
        _ application: UIApplication
    ) { }
    
    // A documentation for this methodd exists in the `LifecycleHandler` type which SwiftLint doesn't recognize.
    // swiftlint:disable:next missing_docs
    public func applicationWillResignActive(
        _ application: UIApplication
    ) { }
    
    // A documentation for this methodd exists in the `LifecycleHandler` type which SwiftLint doesn't recognize.
    // swiftlint:disable:next missing_docs
    public func applicationDidEnterBackground(
        _ application: UIApplication
    ) { }
    
    // A documentation for this methodd exists in the `LifecycleHandler` type which SwiftLint doesn't recognize.
    // swiftlint:disable:next missing_docs
    public func applicationWillEnterForeground(
        _ application: UIApplication
    ) { }
    
    // A documentation for this methodd exists in the `LifecycleHandler` type which SwiftLint doesn't recognize.
    // swiftlint:disable:next missing_docs
    public func applicationWillTerminate(
        _ application: UIApplication
    ) { }
}


extension Array: LifecycleHandler where Element == LifecycleHandler {
    public func willFinishLaunchingWithOptions(
        _ application: UIApplication,
        launchOptions: [UIApplication.LaunchOptionsKey: Any]
    ) {
        for lifecycleHandler in self {
            lifecycleHandler.willFinishLaunchingWithOptions(application, launchOptions: launchOptions)
        }
    }
    
    public func applicationDidBecomeActive(
        _ application: UIApplication
    ) {
        for lifecycleHandler in self {
            lifecycleHandler.applicationDidBecomeActive(application)
        }
    }
    
    public func applicationWillResignActive(
        _ application: UIApplication
    ) {
        for lifecycleHandler in self {
            lifecycleHandler.applicationWillResignActive(application)
        }
    }
    
    public func applicationDidEnterBackground(
        _ application: UIApplication
    ) {
        for lifecycleHandler in self {
            lifecycleHandler.applicationDidEnterBackground(application)
        }
    }
    
    public func applicationWillEnterForeground(
        _ application: UIApplication
    ) {
        for lifecycleHandler in self {
            lifecycleHandler.applicationWillEnterForeground(application)
        }
    }
    
    public func applicationWillTerminate(
        _ application: UIApplication
    ) {
        for lifecycleHandler in self {
            lifecycleHandler.applicationWillTerminate(application)
        }
    }
}
