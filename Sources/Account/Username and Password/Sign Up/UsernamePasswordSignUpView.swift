//
// This source file is part of the CardinalKit open-source project
//
// SPDX-FileCopyrightText: 2022 CardinalKit and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import SwiftUI


struct UsernamePasswordSignUpView: View {
    enum Constants {
        static let formVerticalPadding: CGFloat = 8
    }
    
    
    private let usernameValidationRules: [ValidationRule]
    private let passwordValidationRules: [ValidationRule]
    private let header: AnyView
    private let footer: AnyView
    private let signUpOptions: SignUpOptions
    
    @EnvironmentObject private var usernamePasswordLoginService: UsernamePasswordAccountService
    
    @State private var username = ""
    @State private var password = ""
    @State private var name = PersonNameComponents()
    @State private var dateOfBirth = Date()
    @State private var genderIdentity: GenderIdentity = .preferNotToState
    @State private var state: AccountViewState = .idle
    
    @State private var usernamePasswordValid = false
    @FocusState private var focusedField: AccountInputFields?
    
    private let localization: ConfigurableLocalization<Localization.SignUp>
    
    
    var body: some View {
        Form {
            header
            if signUpOptions.contains(.usernameAndPassword) {
                usernamePasswordSection
            }
            if signUpOptions.contains(.name) {
                Section {
                    NameTextFields(name: $name, focusState: _focusedField)
                }
            }
            if signUpOptions.contains(.dateOfBirth) {
                Section {
                    DateOfBirthPicker(date: $dateOfBirth)
                }
            }
            if signUpOptions.contains(.genderIdentity) {
                Section {
                    GenderIdentityPicker(genderIdentity: $genderIdentity)
                }
            }
            signUpButton
            footer
        }
            .navigationTitle(navigationTitle)
            .viewStateAlert(state: $state)
    }
    
    private var usernamePasswordSection: some View {
        Section {
            Grid(alignment: .leading) {
                switch localization {
                case .environment:
                    UsernamePasswordFields(
                        username: $username,
                        password: $password,
                        valid: $usernamePasswordValid,
                        focusState: _focusedField,
                        usernameValidationRules: usernameValidationRules,
                        passwordValidationRules: passwordValidationRules,
                        presentationType: .signUp(.environment)
                    )
                case let .value(signUp):
                    UsernamePasswordFields(
                        username: $username,
                        password: $password,
                        valid: $usernamePasswordValid,
                        focusState: _focusedField,
                        usernameValidationRules: usernameValidationRules,
                        passwordValidationRules: passwordValidationRules,
                        presentationType: .signUp(
                            .value(
                                (
                                    signUp.username,
                                    signUp.password,
                                    signUp.passwordRepeat,
                                    signUp.passwordNotEqualError
                                )
                            )
                        )
                    )
                }
            }
        }
    }
    
    private var signUpButton: some View {
        let signUpButtonLocalization: String
        switch localization {
        case .environment:
            signUpButtonLocalization = usernamePasswordLoginService.localization.signUp.signUpActionButtonTitle
        case .value(let signUp):
            signUpButtonLocalization = signUp.signUpActionButtonTitle
        }
        
        return Button(action: signUpButtonPressed) {
            Text(signUpButtonLocalization)
                .padding(6)
                .frame(maxWidth: .infinity)
                .opacity(state == .processing ? 0.0 : 1.0)
                .overlay {
                    if state == .processing {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                }
        }
            .buttonStyle(.borderedProminent)
            .disabled(signUpButtonDisabled)
            .padding()
            .padding(-34)
            .listRowBackground(Color.clear)
    }
    
    private var navigationTitle: String {
        switch localization {
        case .environment:
            return usernamePasswordLoginService.localization.signUp.navigationTitle
        case .value(let signUp):
            return signUp.navigationTitle
        }
    }
    
    private var signUpButtonDisabled: Bool {
        let namesInvalid: Bool
        if signUpOptions.contains(.name) {
            if let familyName = name.familyName,
               let givenName = name.givenName {
                namesInvalid = familyName.isEmpty || givenName.isEmpty
            } else {
                namesInvalid = true
            }
        } else {
            namesInvalid = false
        }
        
        return state == .processing || !usernamePasswordValid || namesInvalid
    }
    
    
    init<Header: View, Footer: View>(
        signUpOptions: SignUpOptions = .default,
        usernameValidationRules: [ValidationRule] = [],
        passwordValidationRules: [ValidationRule] = [],
        @ViewBuilder header: () -> Header = { EmptyView() },
        @ViewBuilder footer: () -> Footer = { EmptyView() },
        localization: ConfigurableLocalization<Localization.SignUp> = .environment
    ) {
        self.signUpOptions = signUpOptions
        self.usernameValidationRules = usernameValidationRules
        self.passwordValidationRules = passwordValidationRules
        self.header = AnyView(header())
        self.footer = AnyView(footer())
        self.localization = localization
    }
    
    
    private func signUpButtonPressed() {
        guard !(state == .processing) else {
            return
        }
        
        withAnimation(.easeOut(duration: 0.2)) {
            focusedField = .none
            state = .processing
        }
        
        Task {
            do {
                try await usernamePasswordLoginService.signUp(
                    signInValues: SignInValues(
                        username: username,
                        password: password,
                        name: name,
                        genderIdentity: genderIdentity,
                        dateOfBirth: dateOfBirth
                    )
                )
                withAnimation(.easeIn(duration: 0.2)) {
                    state = .idle
                }
            } catch {
                state = .error(error)
            }
        }
    }
}


struct UsernamePasswordSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            UsernamePasswordSignUpView()
                .environmentObject(UsernamePasswordAccountService())
        }
    }
}
