//
//  NavigatingController.swift
//  SaveEarth
//
//  Created by 김용우 on 10/10/24.
//

import SwiftUI

@Observable
final class Navigator {

  var path: [Screen] = []

  func pop(_ count: Int = 1) {
    path.removeLast(count)
  }

  func push(_ screens: Screen...) {
    path.append(contentsOf: screens)
  }

  func popToRoot() {
    path.removeAll()
  }

  func control(by viewStackControl: ViewStackControl) {
    switch viewStackControl {
      case .push(let screens):
        path.append(contentsOf: screens)

      case .popToRoot:
        path.removeAll()

      case .pop(let count):
        path.removeLast(count)
    }
  }
}
