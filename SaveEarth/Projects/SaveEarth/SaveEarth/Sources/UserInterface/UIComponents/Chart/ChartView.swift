//
//  ChartView.swift
//  SaveEarth
//
//  Created by 송하민 on 6/29/24.
//

//import Charts
import SwiftUI

struct ChartView: View {

  @Binding var lat: CGFloat
  @Binding var lon: CGFloat

  var body: some View {
//    Chart {
//      PointPlot(
//        DataPoint.mockData,
//        x: .value("Longitude", \.mapProjection.xPoint),
//        y: .value("Latitude", \.mapProjection.yPoint)
//      )
//    }
    Text("aaa")
  }
}

#Preview {
  ChartView(lat: .constant(72.5801141), lon: .constant(-38.4688798))
}
