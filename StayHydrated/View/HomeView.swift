//
//  HomeView.swift
//  StayHydrated
//
//  Created by Paul Blanchet on 03/05/2023.
//

import SwiftUI

struct HomeView: View {
    var objectif : Float
    @State var progressValue: Float = 0.0
    var colors = [10,12 ,15, 20, 25,30,33,40, 50, 75,100]
    @State private var selectedValue = 10
    @StateObject var statViewModel = StatViewModel()
    @AppStorage("localStorageID") var localStorageID: String = ""

    
    var body: some View {
        VStack{
            switch(statViewModel.state){
            case .success(let stat) :
                
                Text("Stay Hidrated 💦")
                    .foregroundColor(Color.white)
                    .font(.system(size: 28))
                    .padding()
                
                VStack {
                    ProgressBarView(progress: progressValue == 0 ?(stat.jour1 / (objectif/100))/100 : progressValue)
                        .frame(width: 150.0, height: 150.0)
                        .padding(40.0)
                    
                }
                Spacer()
                
                VStack{
                    HStack{
                        Button(action: {
                            self.incrementProgress(quantity:0.12, stat: stat)
                        }) {
                            HStack {
                                Image(systemName: "plus.rectangle.fill")
                                Text("12 Cl")
                            }
                            .frame(maxWidth: .infinity)
                            .padding(15.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15.0)
                                    .stroke(lineWidth: 2.0)
                            )
                        }
                        
                        Button(action: {
                            self.incrementProgress(quantity:0.2, stat: stat)
                        }) {
                            HStack {
                                Image(systemName: "plus.rectangle.fill")
                                Text("20 Cl")
                            }
                            .frame(maxWidth: .infinity)
                            .padding(15.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15.0)
                                    .stroke(lineWidth: 2.0)
                            )
                        }
                        
                    }
                    .padding()
                    
                    HStack{
                        Button(action: {
                            self.incrementProgress(quantity:0.33, stat: stat)
                        }) {
                            HStack {
                                Image(systemName: "plus.rectangle.fill")
                                Text("33 Cl")
                            }
                            .frame(maxWidth: .infinity)
                            .padding(15.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15.0)
                                    .stroke(lineWidth: 2.0)
                            )
                        }
                        
                        
                        Button(action: {
                            self.incrementProgress(quantity:0.5, stat: stat)
                        }) {
                            HStack {
                                Image(systemName: "plus.rectangle.fill")
                                Text("50 Cl")
                            }
                            .frame(maxWidth: .infinity)
                            .padding(15.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15.0)
                                    .stroke(lineWidth: 2.0)
                            )
                        }
                    }
                    .padding([.bottom, .trailing, .leading],15)
                }
                Spacer()
                
                VStack {
                    HStack{
                        Text("Autre valeur (en Cl) : ")
                        Picker("nombre", selection: $selectedValue) {
                            ForEach(colors, id: \.self) {
                                Text(String($0))
                            }
                        }
                        .frame(width: 100)
                        .clipped()
                        
                        Button("ok"){
                            incrementProgress(quantity: Float(selectedValue)/100, stat: stat)
                        }
                    }
                }
                
                Spacer()
                
            case .loading :
                ProgressView()
                
            default :
                EmptyView()
            }
            
        
                
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "#1C92D2"), Color(hex: "#F2FCFE")]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .task {
            do {
                try await statViewModel.getStat(from: localStorageID)
            } catch {
                // Gérer l'erreur ici
                print("Erreur lors de la récupération de l'utilisateur : \(error)")
            }
        }
        .onAppear(){
            scheduleNotification()
        }
        
    
        
    }
    
    func scheduleNotification() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                if let error = error {
                    print("Erreur lors de la demande d'autorisation de notification : \(error.localizedDescription)")
                    return
                }
                
                if granted {
                    let content = UNMutableNotificationContent()
                    content.title = "StayHydrated"
                    content.body = "Pense à boire de l'eau 💧"
                    content.sound = UNNotificationSound.default
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                    
                    let request = UNNotificationRequest(identifier: "NotificationIdentifier", content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request) { error in
                        if let error = error {
                            print("Erreur lors de l'ajout de la demande de notification : \(error.localizedDescription)")
                        } else {
                            print("Demande de notification ajoutée avec succès.")
                        }
                    }
                } else {
                    print("L'autorisation de notification a été refusée.")
                }
            }
        }

    
    func incrementProgress(quantity:Float, stat:Stat) {
        if(progressValue == 0){
            self.progressValue = (stat.jour1+quantity)/objectif
        }else{
            self.progressValue = progressValue + quantity/objectif
        }
        
        var statToSend : Stat = Stat(id_user: stat.id_user, quantite: 0, jour1: stat.jour1 + quantity, jour2: stat.jour2, jour3: stat.jour3, jour4: stat.jour4, jour5: stat.jour5, jour6: stat.jour6, jour7: stat.jour7)
        Task{
            await sendProgress(quantity :quantity ,stat:statToSend)
        }
    }
    
    func sendProgress (quantity:Float,stat:Stat)async{
         await statViewModel.updateStat(from: stat)
    }
    
    
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(user: )
//    }
//}
