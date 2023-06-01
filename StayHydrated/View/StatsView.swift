//
//  StatsView.swift
//  StayHydrated
//
//  Created by Paul Blanchet on 03/05/2023.
//

import SwiftUI

struct MountPrice: Identifiable {
    var id = UUID()
    var mount: String
    var value: Double
}



struct StatsView: View {
    var objectif : Float
    @StateObject var statViewModel = StatViewModel()
    @AppStorage("localStorageID") var localStorageID: String = ""

    var body: some View {
        VStack {
            switch(statViewModel.state){
            case .success(let stat) :
                Spacer()
                Text("Graphique des 7 derniers jours")
                    .fontWeight(.bold)
                    .font(.system(size: 20))

                    
                ChartView(objectif: objectif, data: [
                    MountPrice(mount: "J-6", value: Double(stat.jour7)),
                    MountPrice(mount: "J-5", value: Double(stat.jour6)),
                    MountPrice(mount: "J-4", value: Double(stat.jour5)),
                    MountPrice(mount: "J-3", value: Double(stat.jour4)),
                    MountPrice(mount: "J-2", value: Double(stat.jour3)),
                    MountPrice(mount: "J-1", value: Double(stat.jour2)),
                    MountPrice(mount: "J", value: Double(stat.jour1)),

                ])
                
            case .loading :
                ProgressView()
                
            default :
                EmptyView()
            }
        }.task{
            do {
                try await statViewModel.getStat(from: localStorageID )
            } catch {
                print("Erreur lors de la récupération des stats : \(error)")
            }
        }
        .frame(width:500)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "#1C92D2"), Color(hex: "#F2FCFE")]),
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
        )
        
    }
}

//struct StatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatsView()
//    }
//}




