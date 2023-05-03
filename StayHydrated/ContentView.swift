//
//  ContentView.swift
//  StayHydrated
//
//  Created by Paul Blanche on 30/03/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            UserView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("User")
                }
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            StatsView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Stats")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
