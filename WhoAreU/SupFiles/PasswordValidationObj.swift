//
//  PasswordValidationObj.swift
//  WhoAreU
//
//  Created by Jadson on 2/01/23.
//

import Foundation
import Combine


class PasswordValidationObj: ObservableObject {
    
    @Published var password = ""
    @Published var validations: [Validation] = []
    @Published var isValid: Bool = false
    
    private var cancelLabelSet: Set<AnyCancellable> = []
    
    init() {
        // Validations
        passwordPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.validations, on: self)
            .store(in: &cancelLabelSet)
        
        // isValid
        passwordPublisher
            .receive(on: RunLoop.main)
            .map { validations in
                return validations.filter { validation in
                    return ValidationState.failure == validation.state
                }.isEmpty
            }
            .assign(to: \.isValid, on: self)
            .store(in: &cancelLabelSet)
    }
    
    private var passwordPublisher: AnyPublisher<[Validation], Never> {
        $password
            .removeDuplicates()
            .map { password in
                
                var validations: [Validation] = []
                validations.append(Validation(string: password,
                                              id: 0,
                                              field: .password,
                                              validationType: .isNotEmpty))
                
                validations.append(Validation(string: password,
                                              id: 1,
                                              field: .password,
                                              validationType: .minCharacters(min: 6)))
                
                validations.append(Validation(string: password,
                                              id: 2,
                                              field: .password,
                                              validationType: .hasSymbols))
                
                validations.append(Validation(string: password,
                                              id: 3,
                                              field: .password,
                                              validationType: .hasUppercasedLetters))
                validations.append(Validation(string: password,
                                              id: 4,
                                              field: .password,
                                              validationType: .hasLowercasedLetters))
                validations.append(Validation(string: password,
                                              id: 5,
                                              field: .password,
                                              validationType: .hasNumbers))
                return validations
            }
            .eraseToAnyPublisher()
    }
}
