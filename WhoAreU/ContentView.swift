//
//  ContentView.swift
//  WhoAreU
//
//  Created by Jadson on 20/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedPerson: PersonModel = PersonModel(id: 1, title: "Child", image: "Child")
    
    var person: [PersonModel] = PersonModel.allPerson()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.16, green: 0.50, blue: 0.73)
                    .edgesIgnoringSafeArea(.all)
                VStack() {
                    Text("WHO YOU ARE?")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        
                    PersonCollection(selectedPerson: $selectedPerson, persons: person)
                        
                }
            }
            .navigationTitle("Sign Up")
            .toolbarBackground(Color.white, for: .navigationBar)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
