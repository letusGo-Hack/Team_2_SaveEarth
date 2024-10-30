//
//  MapView.swift
//  SaveEarth
//
//  Created by 송하민 on 6/29/24.
//

import ComposableArchitecture
import MapKit
import SwiftUI

struct MapView: View {

  @Binding var latitude: CGFloat
  @Binding var longitude: CGFloat

  var body: some View {
    Map(
      initialPosition: .region(region),
      bounds: .init(
        centerCoordinateBounds: region,
        minimumDistance: distanceInMeters,
        maximumDistance: distanceInMeters
      )
    )
  }

  private let distanceInMeters: CLLocationDistance = 15_000_000
  private var region: MKCoordinateRegion {
    .init(
      center: .init(
        latitude: latitude,
        longitude: longitude
      ),
      span: MKCoordinateSpan(
        latitudeDelta: distanceInMeters,
        longitudeDelta: distanceInMeters
      )
    )
  }
}

enum Location {
  case north
  case south

  var latitude: CGFloat {
    switch self {
      case .north:  return 76.571640
      case .south:  return 76.571640
    }
  }

  var logitude: CGFloat {
    switch self {
      case .north:  return -41.666646
      case .south:  return -41.666646
    }
  }
}
