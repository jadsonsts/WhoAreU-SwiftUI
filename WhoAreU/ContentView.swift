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
                    Color(red: 0.75, green: 0.40, blue: 0.30)
                        .edgesIgnoringSafeArea(.all)
                case 1: //child
                    Color(red: 0.6, green: 0.87, blue: 0.80)
                        .edgesIgnoringSafeArea(.all)
                case 2: //teacher
                    Color(red: 0.80, green: 0.70, blue: 0.40)
                        .edgesIgnoringSafeArea(.all)
                default:
                    Color(red: 0.16, green: 0.50, blue: 0.73)
                        .edgesIgnoringSafeArea(.all)
                    
                }
                
                
                VStack{
                    Text("WHO YOU ARE?")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                    
                    PersonCollection(selectedPerson: $selectedPerson, persons:person)
                    if selectedPerson.id == 0 || selectedPerson.id == 1 || selectedPerson.id == 2 {
                        FormView()
                    } else {
                        Text("Please select one")
                            .foregroundColor(.white)
                            .italic()
                            .fontWeight(.semibold)
                        FormView()
                            .disabled(true)
                    }
                    
                    
                }
                .navigationTitle("Sign Up")
                .toolbarBackground(Color.white, for: .navigationBar)
                
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
