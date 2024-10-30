//
//  DataPoint.swift
//  SaveEarth
//
//  Created by 송하민 on 6/29/24.
//

import Foundation
import SwiftUI

struct DataPoint: Identifiable {
  let index: Int
  let id: Int
  let xLongitude: Angle
  let yLatitude: Angle

  let mapProjection: PolarProjection

  internal init(
    index: Int,
    id: Int,
    xLongitude: Angle,
    yLatitude: Angle
  ) {
    self.index = index
    self.id = id
    self.xLongitude = xLongitude
    self.yLatitude = yLatitude
    self.mapProjection = .init(xLongitude: xLongitude, yLatitude: yLatitude)
  }
}

extension DataPoint {
  static var mockData: [Self] = [
    .init(
      index: 0,
      id: 1,
      xLongitude: Angle(degrees: -42.022052),
      yLatitude: Angle(degrees: 75.743682)
    )
  ]
}
