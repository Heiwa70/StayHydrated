//
//  ContentView.swift
//  StayHydrated
//
//  Created by Paul Blanche on 30/03/2023.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @AppStorage("localStorageID") var localStorageID: String = ""
    @State private var showingSheet = true
    @StateObject var viewModel = UserViewModel()
    @StateObject var statViewModel = StatViewModel()
    
    var body: some View {
        
        
        if localStorageID.isEmpty{
            ProgressView()
                .sheet(isPresented: $showingSheet) {
                    FirstLogView(localStorageID: $localStorageID)
                }
        }else{
            VStack{
                switch viewModel.state{
                case .success(let user) :
                    TabView {
                        
                        UserView(user: user , viewModel : viewModel)
                            .tabItem {
                                Image(systemName: "person.fill")
                                Text("User")
                            }
                        
                        HomeView(objectif: user.objectif/100)
                            .tabItem {
                                Image(systemName: "house.fill")
                                Text("Home")
                            }
                        
                        
                        StatsView(objectif: user.objectif)
                            .tabItem {
                                Image(systemName: "chart.bar.xaxis")
                                Text("Stats")
                            }
                    }
                    
                case .loading:
                    ProgressView()
                    
                default:
                    Text(localStorageID)
                    Text("error")
                    Button("Save") {
                        Task {
                            removelocalstorage()
                        }
                    }
                }
            }.task {
                do {
                    try await viewModel.getUser()
                } catch {
                    // Gérer l'erreur ici
                    print("Erreur lors de la récupération de l'utilisateur : \(error)")
                }
            }
        }
        
    }
    private func removelocalstorage()  {
        print(localStorageID)
        UserDefaults.standard.removeObject(forKey: "localStorageID")
    }
    
}

extension Color {
    init(hex: String) {
        var formattedHex = hex
        if formattedHex.hasPrefix("#") {
            formattedHex.remove(at: formattedHex.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: formattedHex).scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
