//
//  MainInterface.swift
//  SaveEarth
//
//  Created by 김용우 on 10/11/24.
//

import SwiftData
import SwiftUI

struct MainInterface: View {
  let dayInfo: DayInfo
  let completeRate: Float

  @State var missionList: [Mission]

  @Query(sort: \DayInfo.date) private var dayInfos: [DayInfo]

  init(dayInfo: DayInfo, completeRate: Float) {
    self.dayInfo = dayInfo
    self.completeRate = completeRate
    self._missionList = State(initialValue: dayInfo.missionList)
  }

  var body: some View {
    VStack {
      Text(completeRate != 1 ? "뜨거운 지구를 구해주세요!! 😱" : "오늘도 지구를 조금 살려냈어요!")
        .font(.title)
        .padding(.vertical)
      Text("Temperature 🌡️")
        .font(.title2)
        .padding()
      HStack {
        Spacer()
        VStack(alignment: .leading) {
          Text("현재온도")
          Text(String(format: "%.2f℃", dayInfo.temperatureData.currentTemperature))
        }
        Spacer()
        VStack(alignment: .leading) {
          Text("평균온도")
          Text(String(format: "%.2f℃", dayInfo.temperatureData.historicTemperature))
        }
        Spacer()
      }
      .font(.title2)
      Spacer()
      if !dayInfo.missionList.allSatisfy(\.isClear) {
        QuestFloatingButton(missionList: $missionList)
      }
    }
    .onChange(of: missionList, initial: false) { oldValue, newValue in
      if newValue != oldValue, let firstIndex = dayInfos.firstIndex(of: dayInfo) {
        dayInfos[firstIndex].missionList = newValue
      }
    }
  }
}
