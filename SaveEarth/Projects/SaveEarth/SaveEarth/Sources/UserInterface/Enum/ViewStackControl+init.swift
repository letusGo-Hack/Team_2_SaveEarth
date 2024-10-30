//
//  ViewStackControl+init.swift
//  SaveEarth
//
//  Created by 김용우 on 8/28/24.
//

import Foundation

extension ViewStackControl {

  init?(of urlComponents: URLComponents) {
    guard let control = urlComponents.host else {
      return nil
    }
    switch control {
      case "push":
        let screenKeys = urlComponents.path.components(separatedBy: "/")
          .compactMap({ Screen(key: $0, query: urlComponents.query) })
        self = .push(screenKeys)

      case "pop":
        let count = urlComponents.queryItems?
          .first(where: { $0.name == "count" })?.value
          .flatMap({ Int($0) }) ?? 1
        self = .pop(count)

      case "popToRoot":
        self = .popToRoot

      default:
        return nil
    }
  }
}
