//
//  ChartView.swift
//  StayHydrated
//
//  Created by Paul Blanchet on 01/06/2023.
//

import SwiftUI
import Charts



struct ChartView: View {
    var objectif : Float
    let data: [MountPrice]
    var body: some View {
        
        Spacer()
        
        Chart(data) {
            LineMark(
                x: .value("Mount", $0.mount),
                y: .value("Value", $0.value)
            )
            PointMark(
                x: .value("Mount", $0.mount),
                y: .value("Value", $0.value)
            )
        }
        .chartYAxis {
            AxisMarks(values: [0, objectif/100*0.25, objectif/100*0.50,objectif/100*0.75, objectif/100, objectif/100*1.25 , objectif/100*1.5])
        }
        .frame(width: 350,height: 400)
        
        .shadow(color: Color.gray.opacity(0.8), radius: 4, x: 0, y: 2)
        
        Spacer()
    }
}

//struct ChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartView()
//    }
//}
