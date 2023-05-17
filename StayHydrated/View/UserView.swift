//
//  UserView.swift
//  StayHydrated
//
//  Created by Paul Blanchet on 03/05/2023.
//

import SwiftUI

struct UserView: View {
    @State private var age: Int = 24
    @State private var taille:Int=180
    @State private var poids:Int = 75
    var activity = ["Tennis", "Badminton", "Football", "Hockey", "Golf" , "Rugby", "Course", "Vélo", "Autre"]
    @State private var selectedActivity = "Autre"
    @State private var autoObj = true


    var body: some View {
        VStack{
            Image(systemName: "checkmark")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .padding(20)
                .background(Color.green)
                .clipShape(Circle())
            
            Spacer()
            
            Text("Paul")
            
            Spacer()
            
            HStack{
                Text("Age : ")
                    .frame(width: 170,alignment: .trailing)
                    
                TextField("Enter your name", value: $age, format : .number)
                    .frame(width: 100)

                    .textFieldStyle(.roundedBorder)
                                    .padding()
            }
            HStack{
                Text("Taille : ")
                    .frame(width: 170,alignment: .trailing)

                TextField("Enter your name", value: $taille, format : .number)
                    .frame(width: 100)

                    .textFieldStyle(.roundedBorder)
                                    .padding()
                
            }
            HStack{
                Text("Poids : ")
                    .frame(width: 170,alignment: .trailing)

                TextField("Enter your name", value: $poids, format : .number)
                    .frame(width: 100)

                    .textFieldStyle(.roundedBorder)
                                    .padding()
                
            }
            
            HStack{
                Text("Activité principale : ")
                    .frame(width: 170,alignment: .trailing)

                Picker("Please choose a color", selection: $selectedActivity) {
                    ForEach(activity, id: \.self) {
                        Text($0)
                    }
                }
                .frame(width: 100)
                .clipped()
            }
            Spacer()

            HStack{
                Text("Objectif : ")
                
                HStack{
                    Toggle("Auto", isOn: $autoObj)

                }.frame(width: 100)
            }
            
            
            
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
