//
//  UserView.swift
//  StayHydrated
//
//  Created by Paul Blanchet on 03/05/2023.
//

import SwiftUI

struct UserView: View {
    @State private var hasChanges = false
    @StateObject var viewModel = UserViewModel()

    @State private var user = User(id_user: 0, nom: "Paul", taille: 180, poids: 75, activite: "Autre", objectif: 200, age: 24, obj_auto: true)

    var activity = ["Tennis", "Badminton", "Football", "Hockey", "Golf" , "Rugby", "Course", "Vélo", "Autre"]
   

    var body: some View {
        VStack{
            AsyncImage(url: URL(string: "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o="))
            { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
                .frame(width: 100, height: 100)
                .padding()
                .clipShape(Circle())
                .aspectRatio(contentMode: .fit)

               
            
            
            Text("Paul")
                .fontWeight(.bold)
                .font(.system(size: 32))
            
            
            HStack{
                Text("Age : ")
                    .frame(width: 150,alignment: .trailing)
                
                TextField("Enter your name", value: $user.age, format : .number)
                    .frame(width: 100)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onChange(of: user.nom) { _ in
                        hasChanges = true
                    }
            }
            HStack{
                Text("Taille : ")
                    .frame(width: 150,alignment: .trailing)

                TextField("Enter your name", value: $user.taille, format : .number)
                    .frame(width: 100)

                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onChange(of: user.taille) { _ in
                        hasChanges = true
                    }
                
            }
            HStack{
                Text("Poids : ")
                    .frame(width: 150,alignment: .trailing)

                TextField("Enter your name", value: $user.poids, format : .number)
                    .frame(width: 100)

                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onChange(of: user.poids) { _ in
                        hasChanges = true
                    }
                
            }
            
            
            HStack{
                Text("Activité principale : ")
                    .frame(width: 150,alignment: .trailing)

                Picker("Please choose a color", selection: $user.activite) {
                    ForEach(activity, id: \.self) {
                        Text($0)
                    }
                }
                .onChange(of: user.activite) { _ in
                    hasChanges = true
                }
                .frame(width: 100)
                .clipped()
            }
            
            Spacer()

            VStack{
                HStack{
                    Text("Objectif : ")
                    
                    HStack{
                        Toggle("Auto", isOn: $user.obj_auto)
                            .onChange(of: user.obj_auto) { _ in
                                hasChanges = true
                            }
                        
                    }.frame(width: 100)
                }
                .padding()
                
                HStack{
                    TextField("Objectif (en Cl)", value: $user.objectif, format : .number)
                        .frame(alignment: .trailing)
                        .onChange(of: user.objectif) { _ in
                            hasChanges = true
                        }
                    Text("Cl")
                        .frame(alignment: .leading)
                    Button("Save") {
                        Task {
                            await saveChanges()
                        }
                    }
//                    .disabled(!hasChanges)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .frame(width:300,height: 20)
                }
                .frame(width: 100,alignment: .center)
                
            }
            Spacer()

        
            
            
        }
        
    }
    private func saveChanges() async {
        hasChanges = true
        
        let result = await viewModel.addUser(from: user)
        print(result)
        
    }
}


struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
