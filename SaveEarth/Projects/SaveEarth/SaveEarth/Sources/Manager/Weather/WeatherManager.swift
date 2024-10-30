//
//  WeatherManager.swift
//  SaveEarth
//
//  Created by 구본의 on 6/29/24.
//

import CoreLocation
import Foundation
import WeatherKit

@Observable
final class WeatherManager {

  private let weatherService: WeatherService

  init() {
    self.weatherService = WeatherService()
  }

  /// 평균 온도와, 현재 온도 반환
  ///
  /// - Parameters:
  ///   - location: 날씨 검색 위치
  func fetchHistoricalTemperature(
    location: CLLocation
  ) async throws -> TemperatureData? {
    guard let mostSignificant = try await weatherService.weather(
      for: location,
      including: .historicalComparisons
    )?.first
    else {
      return nil
    }
    switch mostSignificant {
    case let .highTemperature(trend), let .lowTemperature(trend):
      return TemperatureData(
        historicTemperature: trend.baseline.value.value,
        currentTemperature: trend.currentValue.value
      )
    default: break
    }
    return nil
  }
}
