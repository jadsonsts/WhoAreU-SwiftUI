//
//  PersonCollection.swift
//  WhoAreU
//
//  Created by Jadson on 22/12/22.
//

import SwiftUI

struct PersonCollection: View {
    @Binding var selectedPerson: PersonModel
    
    var persons: [PersonModel]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(persons) { person in
                    Person(selectedPerson: self.$selectedPerson, person: person)
                }
            }
        }
    }
}
