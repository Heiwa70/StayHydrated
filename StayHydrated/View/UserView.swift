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
    @State private var ObjValue:Int = 200

    var body: some View {
        VStack{
            AsyncImage(url: URL(string: "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o="))
            { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
                .frame(width: 150, height: 150)
                .padding()
                .clipShape(Circle())
                .aspectRatio(contentMode: .fit)

               
            
            
            Text("Paul")
                .fontWeight(.bold)
                .font(.system(size: 32))
            
            
            HStack{
                Text("Age : ")
                    .frame(width: 150,alignment: .trailing)
                    
                TextField("Enter your name", value: $age, format : .number)
                    .frame(width: 100)

                    .textFieldStyle(.roundedBorder)
                                    .padding()
            }
            HStack{
                Text("Taille : ")
                    .frame(width: 150,alignment: .trailing)

                TextField("Enter your name", value: $taille, format : .number)
                    .frame(width: 100)

                    .textFieldStyle(.roundedBorder)
                                    .padding()
                
            }
            HStack{
                Text("Poids : ")
                    .frame(width: 150,alignment: .trailing)

                TextField("Enter your name", value: $poids, format : .number)
                    .frame(width: 100)

                    .textFieldStyle(.roundedBorder)
                                    .padding()
                
            }
            
            
            HStack{
                Text("Activité principale : ")
                    .frame(width: 150,alignment: .trailing)

                Picker("Please choose a color", selection: $selectedActivity) {
                    ForEach(activity, id: \.self) {
                        Text($0)
                    }
                }
                
                .frame(width: 100)
                .clipped()
            }
            
            Spacer()

            VStack{
                HStack{
                    Text("Objectif : ")
                    
                    HStack{
                        Toggle("Auto", isOn: $autoObj)
                        
                    }.frame(width: 100)
                }
                .padding()
                
                HStack{
                    TextField("Objectif (en Cl)", value: $ObjValue, format : .number)
                        .frame(alignment: .trailing)
                    Text("Cl")
                        .frame(alignment: .leading)
                }
                .frame(width: 100,alignment: .center)
                
            }
            Spacer()

        }
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
