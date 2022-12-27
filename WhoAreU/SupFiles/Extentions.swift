//
//  Extentions.swift
//  WhoAreU
//
//  Created by Jadson on 27/12/22.
//

import Foundation

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
        let passwordPred = NSPredicate( format: "SELF MATCHES %@", passwordRegex)
        return passwordPred.evaluate(with: self)
    }
    
    func isUpperCase () -> Bool {
        let uppercaseReqRegex = ".*[A-Z]+.*"
        return NSPredicate( format: "SELF MATCHES %@", uppercaseReqRegex).evaluate (with: self)
    }
    
    func isLowerCase () -> Bool {
        let lowercaseReqRegex = ".*[a-z]+.*"
        return NSPredicate(format: "SELF MATCHES %@", lowercaseReqRegex).evaluate (with: self)
    }
    
    func containsCharacter() -> Bool {
        let characterReqRegex = ".*[!@#$%^&*()\\-_=+{}|?>.<]+.*"
        return NSPredicate( format: "SELF MATCHES %@", characterReqRegex).evaluate (with: self)
    }
    
    func containsDigit () -> Bool {
        let digitReqRegex = ".*[0-9]+.*"
        return NSPredicate (format: "SELF MATCHES %@", digitReqRegex).evaluate(with: self)
    }
    
}
