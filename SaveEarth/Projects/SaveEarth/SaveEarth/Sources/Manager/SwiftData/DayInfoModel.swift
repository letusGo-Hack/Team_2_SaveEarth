//
//  SwiftData.swift
//  SaveEarth
//
//  Created by 김용우 on 8/30/24.
//

import Dependencies
import Foundation
import SwiftData

protocol DayInfoModelProtocol {
  var add: @Sendable (DayInfo) throws -> Void { get }
}

struct DayInfoModel: DayInfoModelProtocol {
  static var context: ModelContext?

  var add: @Sendable (DayInfo) throws -> Void

  func updateContext(to context: ModelContext) {
    Self.context = context
  }
}

extension DayInfoModel: DependencyKey {
  static var liveValue: Self {
    .init(
      add: { dayInfo in
        context?.insert(dayInfo)
      }
    )
  }
}

extension DependencyValues {
  var dayInfoModel: DayInfoModel {
    get { self[DayInfoModel.self] }
    set { self[DayInfoModel.self] = newValue }
  }
}
