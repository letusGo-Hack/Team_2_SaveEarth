//
//  PolarMapProjection.swift
//  SaveEarth
//
//  Created by 송하민 on 6/29/24.
//

import Foundation
import SwiftUI

struct Angle {
  var degrees: Double
  var radians: Double {
    return degrees * .pi / 180.0
  }
}

// Azimuthal Equidistant Projection centered on the North Pole
struct PolarProjection: Sendable {
  var xPoint: Double
  var yPoint: Double

  init(xLongitude: Angle, yLatitude: Angle) {
    let centralLatitude = Angle(degrees: 90.0).radians
    let lambda = xLongitude.radians
    let phi = yLatitude.radians
    let rho = centralLatitude - phi
    let theta = lambda

    self.xPoint = rho * sin(theta)
    self.yPoint = -rho * cos(theta)
  }
}
