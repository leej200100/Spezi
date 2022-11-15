//
// This source file is part of the CardinalKit open-source project
//
// SPDX-FileCopyrightText: 2022 CardinalKit and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import CardinalKit
import HealthKit
import HealthKitDataSource
import LocalStorage
import SecureStorage
import SwiftUI


class TestAppDelegate: CardinalKitAppDelegate {
    override var configuration: Configuration {
        Configuration(standard: TestAppStandard()) {
            ObservableComponentTestsComponent(message: "Passed")
            if HKHealthStore.isHealthDataAvailable() {
                HealthKit {
                    CollectSample(
                        HKQuantityType.electrocardiogramType(),
                        deliverySetting: .background(.manual)
                    )
                    CollectSample(
                        HKQuantityType(.stepCount),
                        deliverySetting: .background(.afterAuthorizationAndApplicationWillLaunch)
                    )
                    CollectSample(
                        HKQuantityType(.pushCount),
                        deliverySetting: .anchorQuery(.manual)
                    )
                    CollectSample(
                        HKQuantityType(.activeEnergyBurned),
                        deliverySetting: .anchorQuery(.afterAuthorizationAndApplicationWillLaunch)
                    )
                    CollectSample(
                        HKQuantityType(.restingHeartRate),
                        deliverySetting: .manual()
                    )
                } adapter: {
                    TestAppHealthKitAdapter()
                }
            }
            SecureStorage()
            LocalStorage()
        }
    }
}
