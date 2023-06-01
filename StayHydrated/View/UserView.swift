//
//  UserView.swift
//  StayHydrated
//
//  Created by Paul Blanchet & Clément Seiler on 03/05/2023.
//
import SwiftUI

struct UserView: View {
    @State private var hasChanges = false
    

    @State var showingAlert = false
    @State var user: User
    @StateObject var viewModel : UserViewModel
    var activity = ["Tennis", "Badminton", "Football", "Hockey", "Golf" , "Rugby", "Course", "Velo", "Autre"]

//    var isObjAutoOn: Bool = false
    @State private var isObjAutoOn = false


    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .padding()
            .clipShape(Circle())
            .aspectRatio(contentMode: .fit)
            
            Text(user.nom)
                .fontWeight(.bold)
                .font(.system(size: 32))
            
            Spacer()
            
            VStack {
                Text("Age: ")
                
                TextField("Enter your age", value: $user.age, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: user.age) { _ in
                        hasChanges = true
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
            
            VStack {
                Text("Taille: ")
                
                TextField("Enter your height", value: $user.taille, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: user.taille) { _ in
                        hasChanges = true
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .frame(alignment: .center)

            }
            
            VStack {
                Text("Poids: ")
                
                TextField("Enter your weight", value: $user.poids, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: user.poids) { _ in
                        hasChanges = true
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

            }
            
            VStack {
                Text("Activité principale: ")
                
                Picker("Please choose an activity", selection: $user.activite) {
                    ForEach(activity, id: \.self) {
                        Text($0)
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .onChange(of: user.activite) { _ in
                    hasChanges = true
                }
                .frame(width: 200)
                .clipped()
            }
            
            Spacer()
            
            VStack {
                HStack {
                    Text("Objectif: (en Cl)")
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10))
                    
                    
                    
                    TextField("Objectif", value: $user.objectif, format: .number)
                        .frame(width: 100)
                        .textFieldStyle(.roundedBorder)
                        .onChange(of: user.objectif) { _ in
                            hasChanges = true
                        }
                        .frame(width: 100)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10))

                }
                
                HStack{
                    Button("Sauvegarder") {
                        Task {
                            await saveChanges()
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .frame(height: 20)
                    

                    Button("Supprimer")
                    {
                        deleteUser()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(8)
                    .frame(height: 20)
                    

                }
                
                
            }
            
            Spacer()
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "#1C92D2"), Color(hex: "#F2FCFE")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }

    private func saveChanges() async {
        await viewModel.updateUser(user: user)
        showingAlert = true
        await viewModel.getUser()
        
    }
    
    private func deleteUser() {
        UserDefaults.standard.removeObject(forKey: "localStorageID")
        exit(-1)

    }
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView(user)
//    }
//}

