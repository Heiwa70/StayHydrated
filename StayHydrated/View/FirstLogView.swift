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
    @StateObject var statViewModel = StatViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var user = User(id_user: 0, nom: "", taille: 0, poids: 0, activite: "", objectif: 0, age: 0, obj_auto: 0)
    var activity = ["Autre" ,"Tennis", "Badminton", "Football", "Hockey", "Golf" , "Rugby", "Course", "Vélo" ]

    var isObjAutoOn: Binding<Bool> {
        Binding<Bool>(
            get: {
                return user.obj_auto != 0
            },
            set: { newValue in
                user.obj_auto = newValue ? 1 : 0
            }
        )
    }

    var body: some View {
        VStack {
            Text("Bienvenue sur Stay Hydrated!")
                .fontWeight(.bold)
                .font(.system(size: 20))
                .padding()
            Text("Remplissez ces informations pour commencer !")
            
            HStack {
                Text("Nom: ")
                    .frame(width: 150, alignment: .trailing)
                
                TextField("Enter your name", text: $user.nom)
                    .frame(width: 100)
                    .textFieldStyle(.roundedBorder)
                    .padding()
            }
            
            HStack {
                Text("Age: ")
                    .frame(width: 150, alignment: .trailing)
                
                TextField("Enter your age", value: $user.age, format: .number)
                    .frame(width: 100)
                    .textFieldStyle(.roundedBorder)
                    .padding()
            }
            
            HStack {
                Text("Taille: ")
                    .frame(width: 150, alignment: .trailing)
                
                TextField("Enter your height", value: $user.taille, format: .number)
                    .frame(width: 100)
                    .textFieldStyle(.roundedBorder)
                    .padding()
            }
            
            HStack {
                Text("Poids: ")
                    .frame(width: 150, alignment: .trailing)
                
                TextField("Enter your weight", value: $user.poids, format: .number)
                    .frame(width: 100)
                    .textFieldStyle(.roundedBorder)
                    .padding()
            }
            
            HStack {
                Text("Activité principale: ")
                    .frame(width: 150, alignment: .trailing)
                
                Picker("Please choose an activity", selection: $user.activite) {
                    ForEach(activity, id: \.self) {
                        Text($0)
                    }
                }
                .frame(width: 100)
                .clipped()
            }
            
            HStack {
                Text("Objectif (en Cl) : ")
                    .frame(width: 150, alignment: .trailing)
                
                TextField("Enter your objectif", value: $user.objectif, format: .number)
                    .frame(width: 100)
                    .textFieldStyle(.roundedBorder)
                    .padding()
            }
            Button("Go !") {
                Task {
                    await saveChanges()
                }
            }
        }
    }

    private func saveChanges() async {
        let result = await viewModel.addUser(from: user)
        var stat : Stat = Stat(id_user: (result as NSString).integerValue, quantite: 0, jour1: 0, jour2: 0, jour3: 0, jour4: 0, jour5: 0, jour6: 0, jour7: 0)
        await statViewModel.addStat(from: stat)
        print(result)
        localStorageID = result
        
    }
}
