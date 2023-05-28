//
//  FirstLogView.swift
//  StayHydrated
//
//  Created by Paul Blanchet on 03/05/2023.
//

import SwiftUI

struct FirstLogView: View {
    @Binding var localStorageID: String
    @StateObject var viewModel = UserViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var user = User(id_user: 0, nom: "Paul", taille: 180, poids: 75, activite: "Autre", objectif: 200, age: 24, obj_auto: true)
    var activity = ["Tennis", "Badminton", "Football", "Hockey", "Golf" , "Rugby", "Course", "Vélo", "Autre"]
   

        var body: some View {
            VStack{
                Spacer()
                Text("Bienvenue sur Stay Hydrated !")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .padding()
                Text("Remplissez ces informations pour commencer !")
                Spacer()

                HStack{
                    Text("Nom : ")
                        .frame(width: 150,alignment: .trailing)
                    
                    TextField("Enter your name", text: $user.nom)
                        .frame(width: 100)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }
                
                HStack{
                    Text("Age : ")
                        .frame(width: 150,alignment: .trailing)
                    
                    TextField("Enter your name", value: $user.age, format : .number)
                        .frame(width: 100)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }
                HStack{
                    Text("Taille : ")
                        .frame(width: 150,alignment: .trailing)
                    
                    TextField("Enter your name", value: $user.taille, format : .number)
                        .frame(width: 100)
                    
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    
                }
                HStack{
                    Text("Poids : ")
                        .frame(width: 150,alignment: .trailing)
                    
                    TextField("Enter your name", value: $user.poids, format : .number)
                        .frame(width: 100)
                    
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    
                }
                
                
                HStack{
                    Text("Activité principale : ")
                        .frame(width: 150,alignment: .trailing)
                    
                    Picker("Please choose a color", selection: $user.activite) {
                        ForEach(activity, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    .frame(width: 100)
                    .clipped()
                }
                                
                VStack{
                    HStack{
                        Text("Objectif : ")
                        
                        HStack{
                            Toggle("Auto", isOn: $user.obj_auto)
                            
                            
                        }.frame(width: 100)
                    }
                    .padding()
                    
                    HStack{
                        TextField("Objectif (en Cl)", value: $user.objectif, format : .number)
                            .frame(alignment: .trailing)
                        
                        Text("Cl")
                            .frame(alignment: .leading)
                        Button("Sauvegarder") {
                            Task {
                                await saveChanges()
                            }
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .frame(width:300,height: 20)
                    }
                    .frame(width: 100,alignment: .center)
                    
                }
            }
        }
    private func saveChanges() async {
        let result = await viewModel.addUser(from: user)
        print(result)
        localStorageID = result

        
    }
}

