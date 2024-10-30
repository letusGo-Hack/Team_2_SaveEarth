//
//  SaveEarthApp.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import SwiftData
import SwiftUI

import ComposableArchitecture

@main
struct SaveEarthApp: App {

  @AppStorage(AppStorageKeys.onboarding) var isOnboarding: Bool = false

  var body: some Scene {
    WindowGroup {
      if isOnboarding {
        RootView()
          .modelContainer(for: DayInfo.self)
      } else {
        // 온보딩 화면을 보지 않은 경우 분기 처리
        OnboardingView()
      }
    }
  }
}
