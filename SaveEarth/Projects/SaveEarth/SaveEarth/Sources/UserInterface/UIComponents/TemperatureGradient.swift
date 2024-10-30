//
//  TemperatureGradient.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import SwiftUI

struct TemperatureGradient: View {
    let complete: Float

    var heightRatio: Float { complete == .zero ? 0.1 : (1 + complete) * 0.5 }
    var topColor: Color { heightRatio == 1.0 ? .white : .blue }
    var middleColor: Color { heightRatio == 1.0 ? .blue : .yellow }

    var body: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: [
                [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                [0.0, heightRatio], [0.5, heightRatio], [1.0, heightRatio],
                [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
            ],
            colors: [
                topColor, topColor, topColor,
                middleColor, middleColor, middleColor,
                .red, .red, .red
            ]
        )
        .opacity(0.6)
    }
}

#Preview("complete 0") {
    TemperatureGradient(complete: 0)
}

#Preview("complete 0.5") {
    TemperatureGradient(complete: 0.5)
}

#Preview("complete 1") {
    TemperatureGradient(complete: 1)
}
