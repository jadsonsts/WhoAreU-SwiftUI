//
//  ContentView.swift
//  WhoAreU
//
//  Created by Jadson on 20/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedPerson = PersonModel()
    
    var person: [PersonModel] = PersonModel.allPerson()
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                switch selectedPerson.id {
                case 0: //parent
                    Color(red: 0.65, green: 0.20, blue: 0.20)
                        .edgesIgnoringSafeArea(.all)
                case 1: //child
                    Color(red: 0.6, green: 0.87, blue: 0.80)
                        .edgesIgnoringSafeArea(.all)
                case 2: //teacher
                    Color(red: 0.90, green: 0.45, blue: 0.20)
                        .edgesIgnoringSafeArea(.all)
                default:
                    Color(red: 0.16, green: 0.50, blue: 0.73)
                        .edgesIgnoringSafeArea(.all)
                    
                }
                

                VStack{
                    Text("WHO YOU ARE?")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                    
                    PersonCollection(selectedPerson: $selectedPerson, persons: person)
                    FormView()
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
