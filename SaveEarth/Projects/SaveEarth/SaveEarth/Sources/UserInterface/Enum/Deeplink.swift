//
//  Deeplink.swift
//  SaveEarth
//
//  Created by 김용우 on 8/28/24.
//

import SwiftUI

enum Deeplink {
  private static var scheme: String {
    #if RELEASE
    "saveearth://"
    #else
    "saveearth-dev://"
    #endif
  }

  static func openSelf(path: String) {
    if let url = URL(string: scheme + path) {
      Self.open(url)
    } else {
      // TODO: Error 처리 추가
    }
  }

  static func open(_ url: URL) {
    if UIApplication.shared.canOpenURL(url) {
      Task { @MainActor in
        UIApplication.shared.open(url)
      }
    } else {
      // TODO: Error 처리 추가
    }
  }

  /// ViewStackControl 에 따른 동작을 요청
  ///
  /// - Note: 각 case absoluteString 예시
  /// .push: "saveearth://push/setting/notification?exampleMessage=1"
  /// .popToRoot: "saveearth://popToRoot"
  /// .pop: "saveearth://pop?count=3"
  static func open(of control: ViewStackControl) {
    switch control {
      case .push(let screens):
        let tuples = screens.map({ ($0.key, $0.query) })
        let keysPath = tuples.map({ $0.0 }).joined(separator: "/")
        let quriesPath = tuples.compactMap({ $0.1 }).joined(separator: "&")
        Self.openSelf(path: "push/" + keysPath + (quriesPath.isEmpty ? "" : "?" + quriesPath))

      case .popToRoot:
        Self.openSelf(path: "popToRoot")

      case .pop(let count):
        Self.openSelf(path: "pop?count=\(count)")
    }
  }
}
