//
//  HomeView.swift
//  StayHydrated
//
//  Created by Paul Blanchet on 03/05/2023.
//

import SwiftUI

struct HomeView: View {
    @State var progressValue: Float = 0.1

    var body: some View {
        VStack{
            Text("Stay Hidrated 💦")
                .foregroundColor(Color.blue)
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
                            self.decrementProgress()
                        }) {
                            HStack {
                                Image(systemName: "minus.rectangle.fill")
                                Text("Decrement")
                            }
                            .padding(15.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15.0)
                                    .stroke(lineWidth: 2.0)
                            )
                        }
                        Button(action: {
                            self.decrementProgress()
                        }) {
                            HStack {
                                Image(systemName: "minus.rectangle.fill")
                                Text("Decrement")
                            }
                            .padding(15.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15.0)
                                    .stroke(lineWidth: 2.0)
                            )
                        }
                    }
                    HStack{
                        Button(action: {
                            self.decrementProgress()
                        }) {
                            HStack {
                                Image(systemName: "minus.rectangle.fill")
                                Text("Decrement")
                            }
                            .padding(15.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15.0)
                                    .stroke(lineWidth: 2.0)
                            )
                        }
                        Button(action: {
                            self.decrementProgress()
                        }) {
                            HStack {
                                Image(systemName: "minus.rectangle.fill")
                                Text("Decrement")
                            }
                            .padding(15.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15.0)
                                    .stroke(lineWidth: 2.0)
                            )
                        }
                    }
                
            }
            Spacer()
        }
    }
    
    
    func incrementProgress() {
            let randomValue = Float([0.012, 0.022, 0.034, 0.016, 0.11].randomElement()!)
            self.progressValue += randomValue
        }
    
    func decrementProgress() {
            let randomValue = Float([0.012, 0.022, 0.034, 0.016, 0.11].randomElement()!)
            self.progressValue -= randomValue
        }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
