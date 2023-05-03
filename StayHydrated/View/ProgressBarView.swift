//
//  ProgressBarView.swift
//  StayHydrated
//
//  Created by Paul Blanchet on 03/05/2023.
//

import SwiftUI

struct ProgressBarView: View {
    @Binding var progress: Float
        
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.blue)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(self.progress))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.blue)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
            
            Text(String(format: "%.0f %%", self.progress*100.0))
                .font(.largeTitle)
                .bold()
        }
    }
}
