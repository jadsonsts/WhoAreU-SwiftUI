//
//  Extentions.swift
//  WhoAreU
//
//  Created by Jadson on 27/12/22.
//

import Foundation
import SwiftUI

enum Field: String {
    case username
    case password
}

enum ValidationState {
    case success
    case failure
}

enum ValidationType {
    case isNotEmpty
    case minCharacters(min: Int)
    case hasSymbols
    case hasUppercasedLetters
    case hasLowercasedLetters
    case hasNumbers
    
    func fulfills(string: String) -> Bool {
        switch self {
        case .isNotEmpty:
            return !string.isEmpty
        case .minCharacters(min: let min):
            return string.count > min
        case .hasSymbols:
            return string.containsCharacter()
        case .hasUppercasedLetters:
            return string.isUpperCase()
        case .hasLowercasedLetters:
            return string.isLowerCase()
        case .hasNumbers:
            return string.containsDigit()
        }
    }
    
    func message(fieldName: String) -> String {
            switch self {
            case .isNotEmpty:
                return "\(fieldName) must not be empty"
            case .minCharacters(min: let min):
                return "\(fieldName) must be at least \(min) characters"
            case .hasSymbols:
                return "\(fieldName) must contain a symbol"
            case .hasUppercasedLetters:
                return "\(fieldName) must cointain at least one upper case character"
            case .hasLowercasedLetters:
                return "\(fieldName) must cointain at least one lower case character"
            case .hasNumbers:
                return "\(fieldName) must cointain at least one number"
            }
        }
}

//MARK: - VALIDATIONS

struct Validation: Identifiable {
    var id: Int
    var field: Field
    var validationType: ValidationType
    var state: ValidationState
    
    init(string: String, id: Int, field: Field, validationType: ValidationType) {
        self.id = id
        self.field = field
        self.validationType = validationType
        self.state = validationType.fulfills(string: string) ? .success : .failure
    }
}

//MARK: - TEXT FIELD STYLE
struct ThemeTxeField: TextFieldStyle {
    
    @State var icon: Image?
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            if icon != nil {
                icon
                    .foregroundColor(.white) //change to white
            }
            configuration
        }
        .padding(.vertical)
        .padding(.horizontal, 24)
        .foregroundColor(.white)
        .fontWeight(.semibold)
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.white, lineWidth: 2) //change to white
        }
        .background(Color.clear)
        .scrollDismissesKeyboard(.immediately)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
    }
}

//MARK: - EMAIL AND PASSWORD REGEX
extension String {
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx =
        "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}"
        + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
        + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
        + "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
        + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
        + "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
        + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func isPassword() -> Bool {
        let passwordRegex =
        "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<]{6,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPred.evaluate(with: self)
    }
    
    func isUpperCase () -> Bool {
        let uppercaseReqRegex = ".*[A-Z]+.*"
        return NSPredicate(format: "SELF MATCHES %@", uppercaseReqRegex).evaluate (with: self)
    }
    
    func isLowerCase () -> Bool {
        let lowercaseReqRegex = ".*[a-z]+.*"
        return NSPredicate(format: "SELF MATCHES %@", lowercaseReqRegex).evaluate (with: self)
    }
    
    func containsCharacter() -> Bool {
        let characterReqRegex = ".*[!@#$%^&*()\\-_=+{}|?>.<]+.*"
        return NSPredicate(format: "SELF MATCHES %@", characterReqRegex).evaluate (with: self)
    }
    
    func containsDigit () -> Bool {
        let digitReqRegex = ".*[0-9]+.*"
        return NSPredicate (format: "SELF MATCHES %@", digitReqRegex).evaluate(with: self)
    }
    
}

