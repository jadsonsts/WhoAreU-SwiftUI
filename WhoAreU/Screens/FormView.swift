//
//  Form.swift
//  WhoAreU
//
//  Created by Jadson on 23/12/22.
//

import SwiftUI

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
    }
}

struct FormView: View {
    
    @ObservedObject var emailValidation = EmailValidationObj()
    @ObservedObject var passwordValidation = PasswordValidationObj()
    
    @State private var formData = FormModel()
    
    var body: some View {
        Form {
            Text("Personal Information")
                .italic()
            Section {
                TextField("First Name", text: $formData.firstName)
                    .textFieldStyle(ThemeTxeField(icon: Image(systemName: "person.fill")))
                
                TextField("Last Name", text: $formData.lastName)
                    .textFieldStyle(ThemeTxeField(icon: Image(systemName: "person.fill")))
                
                TextField("E-mail", text: $emailValidation.email)
                    .textFieldStyle(ThemeTxeField(icon: Image(systemName: "envelope.fill")))
                    .keyboardType(.emailAddress)
                Text(emailValidation.error)
                    .font(.footnote)
                    .foregroundColor(.white)
            }
            .listRowBackground(Color.clear) // to clear the background of the section list
            Text("Account Details")
                .italic()
            Section {
                TextField("User Name", text: $formData.userName)
                    .textFieldStyle(ThemeTxeField(icon: Image(systemName: "person.circle.fill")))
                SecureField("Password", text: $passwordValidation.password)
                    .textFieldStyle(ThemeTxeField(icon: Image(systemName: "lock")))
                Text(passwordValidation.error)
                    .font(.footnote)
                    .foregroundColor(.white)
                SecureField("Confirm Password", text: $formData.confPassword)
                    .textFieldStyle(ThemeTxeField(icon: Image(systemName: "lock")))
            }
            .listRowBackground(Color.clear)
            
            Section {
                SubmitBtn()
                    .frame(height: 95)
                
            }
            .listRowBackground(Color.clear)
        }
        .scrollContentBackground(.hidden) //to clear the background of the form
    }
}

struct Form_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}


class EmailValidationObj: ObservableObject {
    @Published var email = "" {
        didSet {
            if email.isEmpty {
                error = "Required"
            } else if !email.isValidEmail(email){
                error = "Invalid email"
            } else {
                error = ""
            }
        }
    }
    
    @Published var error = ""
}

class PasswordValidationObj: ObservableObject {
    @Published var password = "" {
        didSet {
            self.isValidPassword()
        }
    }
    
    @Published var error = ""
    
    private func isValidPassword() {
        guard !password.isEmpty else { return error = "Required" }
        
        let setPassError = password.isPassword() == false
        
        if setPassError {
            if password.count < 6 {
                self.error = "Password must be at least 6 characters"
            }
        }
        if !password.isUpperCase() {
            self.error = "Password must cointain at least one upper case character"
        } else if !password.isLowerCase() {
            self.error = "Password must cointain at least one lower case character"
        } else if !password.containsDigit() {
            self.error = "Password must cointain at least one number"
        } else if !password.containsCharacter() {
            self.error = "Password must cointain at least one special character"
        } else {
            error = ""
        }
    }
}
