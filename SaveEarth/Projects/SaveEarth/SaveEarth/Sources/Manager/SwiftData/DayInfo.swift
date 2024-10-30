//
//  DayInfo.swift
//  SaveEarth
//
//  Created by Importants on 6/29/24.
//

import Foundation
import SwiftData

@Model
final class DayInfo {
  #Unique<DayInfo>([\.date])
  let date: Date
  let temperatureData: TemperatureSwiftDataModel
  var missionList: [Mission]

  public init(
    date: Date,
    temperatureData: TemperatureSwiftDataModel,
    missionList: [Mission]
  ) {
    self.date = date
    self.temperatureData = temperatureData
    self.missionList = missionList
  }
}

extension DayInfo {

  var isToday: Bool {
    Calendar.current.isDateInToday(date)
  }
}
