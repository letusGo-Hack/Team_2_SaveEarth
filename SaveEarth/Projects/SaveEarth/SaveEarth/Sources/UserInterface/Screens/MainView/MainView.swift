//
//  ContentView.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import ComposableArchitecture
import SwiftData
import SwiftUI

struct MainView: View {
  @Environment(WeatherManager.self) var weatherManager
  @Environment(\.modelContext) var modelContext
  @Query(sort: \DayInfo.date) private var dayInfos: [DayInfo]

  @State var latitude: CGFloat = 76.571640
  @State var longitude: CGFloat = -41.666646

  var dayInfo: DayInfo? { dayInfos.first(where: { $0.isToday }) }
  var isCleared: Bool? { dayInfo?.missionList.allSatisfy(\.isClear) }
  var completeRate: Float {
    if let missionList = dayInfo?.missionList {
      let clearedCount = missionList.filter(\.isClear).count
      return Float(clearedCount) / Float(missionList.count)
    } else {
      return .zero
    }
  }

  var body: some View {
    ZStack {
      MapView(
        latitude: $latitude,
        longitude: $longitude
      )
      .overlay {
        TemperatureGradient(complete: completeRate)
          .overlay(alignment: .center) {
            if let isCleared = isCleared {
              if isCleared {
                CompleteQuestView()
              } else {
                Image(systemName: "flame.fill")
                  .foregroundColor(.red)
                  .font(.largeTitle)
              }
            }
          }
          .ignoresSafeArea()
      }
      if let dayInfo = dayInfo {
        MainInterface(
          dayInfo: dayInfo,
          completeRate: completeRate
        )
      } else {
        ProgressView()
      }
    }
    .task {
      try? await updateCurrentLocationTemperature()
    }
    .toolbarVisibility(.hidden, for: .navigationBar)
  }
}

extension MainView {

  private func updateCurrentLocationTemperature() async throws {
    // FIXME: WeatherKit 인증 이슈 해결 필요
//    guard let response = try await weatherManager.fetchHistoricalTemperature(
//      location: .init(latitude: latitude, longitude: longitude)
//    ) else {
//      return print("Failed to fetch historical temperature")
//    }
//
    let currentTemperature = 6.0// response.currentTemperature
    let historicTemperature = 0.0//response.historicTemperature

    let count = abs(Int(historicTemperature - currentTemperature))

//    // TODO: 온도 차이 Display

    guard dayInfo == nil else {
      return print("Local weather already exists.")
    }
    
    add(
      DayInfo(
        date: Date.now,
        temperatureData: .init(
          historicTemperature: historicTemperature,
          currentTemperature: currentTemperature
        ),
        missionList: Mission.makeMissionList(count: count > 5 ? 5 : count)
      )
    )
  }

  private func add(_ dayInfo: DayInfo) {
    modelContext.insert(dayInfo)
  }

}

fileprivate extension Mission {

  static func makeMissionList(
    count: Int
  ) -> [Mission] {
    let questList: [String] = [
      "페트병 분리수거 하기 🫡",
      "에어컨 1도 낮추기 😎",
      "오늘 하루 텀블러 사용하기 😙",
      "종이컵 사용하지 않기",
      "대중교통 이용하기",
      "낮에는 전등 끄기",
      "사용하지 않는 콘센트 선 뽑아 놓기"
    ]
    var indexes = Set<Int>()

    while indexes.count < count {
      let randomIndex = Int.random(in: 0..<questList.count)
      indexes.update(with: randomIndex)
    }

    return indexes.map({ Mission(title: questList[$0]) })
  }
}

// MARK: - Preview

#Preview {
  MainView()
}
