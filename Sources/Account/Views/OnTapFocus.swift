//
// This source file is part of the CardinalKit open-source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


struct OnTapFocus<FocusedField: Hashable>: ViewModifier {
    private let fieldIdentifier: FocusedField
    
    @FocusState private var focusedState: FocusedField?
    
    
    init(
        focusedState: FocusState<FocusedField?>,
        fieldIdentifier: FocusedField
    ) {
        self._focusedState = focusedState
        self.fieldIdentifier = fieldIdentifier
    }
    
    init() where FocusedField == UUID {
        self.init(
            focusedState: FocusState<FocusedField?>(),
            fieldIdentifier: UUID()
        )
    }
    
    
    func body(content: Content) -> some View {
        content
            .focused($focusedState, equals: fieldIdentifier)
            .onTapGesture {
                focusedState = fieldIdentifier
            }
    }
}


extension View {
    func onTapFocus() -> some View {
        modifier(OnTapFocus())
    }
    
    func onTapFocus<FocusedField: Hashable>(
        focusedField: FocusState<FocusedField?>,
        fieldIdentifier: FocusedField
    ) -> some View {
        modifier(OnTapFocus(focusedState: focusedField, fieldIdentifier: fieldIdentifier))
    }
}
