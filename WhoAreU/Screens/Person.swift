//
//  Person.swift
//  WhoAreU
//
//  Created by Jadson on 22/12/22.
//

import SwiftUI

struct Person: View {
    @Binding var selectedPerson: PersonModel
    
    var person: PersonModel
    
    var body: some View {
        VStack(alignment: .center) {
            if person == self.selectedPerson {
                Image(person.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .shadow(radius: 3)
                    .opacity(1.0)
            } else {
                Image(person.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 3))
                    .shadow(radius: 3)
                    .opacity(0.5)
            }
            
            Text(person.title!)
                .fontWeight(.bold)
                .fontDesign(.rounded)
                .font(.headline)
        }
        .frame(width: 130, height: 130)
        .onTapGesture {
            self.selectedPerson = self.person
        }
    }
}
