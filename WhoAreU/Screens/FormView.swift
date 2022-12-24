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
                
                TextField("E-mail", text: $formData.email)
                    .textFieldStyle(ThemeTxeField(icon: Image(systemName: "envelope.fill")))
                    .keyboardType(.emailAddress)
            }
            .listRowBackground(Color.clear) // to clear the background of the section list
            Text("Account Details")
                .italic()
            Section {
                TextField("User Name", text: $formData.userName)
                    .textFieldStyle(ThemeTxeField(icon: Image(systemName: "person.circle.fill")))
                TextField("Password", text: $formData.password)
                    .textFieldStyle(ThemeTxeField(icon: Image(systemName: "lock")))
                TextField("Confirm Password", text: $formData.confPassword)
                    .textFieldStyle(ThemeTxeField(icon: Image(systemName: "lock")))
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
