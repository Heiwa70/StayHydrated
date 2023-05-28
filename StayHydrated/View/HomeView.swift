//
//  HomeView.swift
//  StayHydrated
//
//  Created by Paul Blanchet on 03/05/2023.
//

import SwiftUI

struct HomeView: View {
    @State var progressValue: Float = 0.1
    var colors = ["10 Cl","12 Cl" ,"15 Cl", "20 Cl", "25 Cl","30 Cl","33 Cl" ,"40 Cl", "50 Cl", "75 Cl", "1 L"]
    @State private var selectedColor = "10 Cl"


    var body: some View {
        VStack{
            Text("Stay Hidrated 💦")
                .foregroundColor(Color.white)
                .font(.system(size: 28))
                .padding()
            
            VStack {
                ProgressBarView(progress: self.$progressValue)
                    .frame(width: 150.0, height: 150.0)
                    .padding(40.0)
                
            }
            Spacer()
            
            VStack{
                HStack{
                    Button(action: {
                        self.incrementProgress(quantity:0.12)
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
                        self.incrementProgress(quantity:0.2)
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
                        self.incrementProgress(quantity:0.33)
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
                        self.incrementProgress(quantity:0.5)
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
                    Text("Autre valeur : ")
                    Picker("Please choose a color", selection: $selectedColor) {
                        ForEach(colors, id: \.self) {
                            Text($0)
                        }
                    }
                    .frame(width: 100)
                    .clipped()
                }
            }
            
            Spacer()
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "#4ca1af"), Color(hex: "#c4e0e5")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        
    
    }
    
    func incrementProgress(quantity:Float) {
            self.progressValue += quantity
        }
    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
