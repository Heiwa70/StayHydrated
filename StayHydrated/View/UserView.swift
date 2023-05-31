//
//  UserView.swift
//  StayHydrated
//
//  Created by Paul Blanchet & Clément Seiler on 03/05/2023.
//
import SwiftUI

struct UserView: View {
    @State private var hasChanges = false
    
    @StateObject var viewModel = UserViewModel()

    @State var showingAlert = false
    @State var user: User

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

            HStack {
                Text("Age: ")
                    .frame(width: 150, alignment: .trailing)

                TextField("Enter your age", value: $user.age, format: .number)
                    .frame(width: 100)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onChange(of: user.age) { _ in
                        hasChanges = true
                    }
            }

            HStack {
                Text("Taille: ")
                    .frame(width: 150, alignment: .trailing)

                TextField("Enter your height", value: $user.taille, format: .number)
                    .frame(width: 100)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onChange(of: user.taille) { _ in
                        hasChanges = true
                    }
            }

            HStack {
                Text("Poids: ")
                    .frame(width: 150, alignment: .trailing)

                TextField("Enter your weight", value: $user.poids, format: .number)
                    .frame(width: 100)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onChange(of: user.poids) { _ in
                        hasChanges = true
                    }
            }

            HStack {
                Text("Activité principale: ")
                    .frame(width: 150, alignment: .trailing)

                Picker("Please choose an activity", selection: $user.activite) {
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

            VStack {
                HStack {
                    Text("Objectif: ")

                    HStack {
                        Toggle("Auto", isOn: $isObjAutoOn)
                            .onChange(of: user.obj_auto) { _ in
                                hasChanges = true
                            }
                    }
                    TextField("Objectif", value: $user.objectif, format: .number)
                        .frame(width: 100)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .onChange(of: user.poids) { _ in
                            hasChanges = true
                        }
                    .frame(width: 100)
                }
                .padding()

                HStack {
                    TextField("Objectif (en Cl)", value: $user.objectif, format: .number)
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
                    .alert("Infos mises à jours", isPresented : $showingAlert){
                        Button("OK", role: .cancel) {}
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .frame(width: 300, height: 20)
                }
                .frame(width: 100, alignment: .center)
            }

            Spacer()
        }
    }

    private func saveChanges() async {
        hasChanges = true
        
        let result = await viewModel.updateUser(user: user)
        print(result)
        showingAlert = true
        
    }
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView(user)
//    }
//}
//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView(user: .constant(User()))
//    }
//}
