//
//  Form.swift
//  WhoAreU
//
//  Created by Jadson on 23/12/22.
//

import SwiftUI

struct FormView: View {

    @ObservedObject private var emailValidation = EmailValidationObj()
    @ObservedObject private var passwordValidation = PasswordValidationObj()
    
    @State private var formData = FormModel()
    
    var isFormComplete: Bool {
        return formData.firstName.isEmpty || formData.lastName.isEmpty || formData.userName.isEmpty || emailValidation.email.isEmpty || passwordValidation.password.isEmpty || formData.confPassword.isEmpty
    }
    
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
                if emailValidation.error != "" {
                    Text(emailValidation.error)
                        .font(.footnote)
                        .foregroundColor(.red)
                }
                
            }
            .listRowBackground(Color.clear) // to clear the background of the section list
            Text("Account Details")
                .italic()
            Section {
                TextField("User Name", text: $formData.userName)
                    .textFieldStyle(ThemeTxeField(icon: Image(systemName: "person.circle.fill")))
                SecureField("Password", text: $passwordValidation.password)
                        .textFieldStyle(ThemeTxeField(icon: Image(systemName: "lock")))
                if passwordValidation.password.count >= 1 {
                    List(passwordValidation.validations) { validation in
                        HStack {
                            Image(systemName: validation.state == .success ? "checkmark.circle.fill" : "checkmark.circle")
                                .foregroundColor(validation.state == .success ? Color.green : Color.gray.opacity(0.3))
                            Text(validation.validationType.message(fieldName: validation.field.rawValue))
                                .strikethrough(validation.state == .success)
                                .font(Font.caption)
                                .foregroundColor(validation.state == .success ? Color.gray : .black)
                        }
                        .padding([.leading], 15)
                        }
                }

                if passwordValidation.password.count < 6 {
                    SecureField("Confirm Password", text: $formData.confPassword)
                        .textFieldStyle(ThemeTxeField(icon: Image(systemName: "lock")))
                        .disabled(true)
                } else {
                    SecureField("Confirm Password", text: $formData.confPassword)
                        .textFieldStyle(ThemeTxeField(icon: Image(systemName: "lock")))
                }
                
                if formData.confPassword != passwordValidation.password {
                    Text("Both fields must be the same")
                        .font(.footnote)
                        .foregroundColor(.white)
                }

                    
                }
            .listRowBackground(Color.clear)
            
            Section {
                SubmitBtn()
                    .frame(height: 95)
                    .disabled(isFormComplete)
                    .onTapGesture {
                        clearFields()
                    }
                
            }
            .listRowBackground(Color.clear)
        }
        .scrollContentBackground(.hidden) //to clear the background of the form
    }
    public func clearFields() {
        formData.lastName = ""
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


