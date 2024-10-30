//
//  Screen+init.swift
//  SaveEarth
//
//  Created by 김용우 on 8/28/24.
//

extension Screen {

  init?(key: String, query: String?) {
    guard let queryDictionary = query.flatMap({
      Dictionary(
        uniqueKeysWithValues: $0
          .replacingOccurrences(of: "?", with: "")
          .components(separatedBy: "&")
          .map({ $0.components(separatedBy: "=") })
          .map({ ($0[0], $0[1]) })
      )
    }) else {
      return nil
    }
    switch key {
      case "setting":
        self = .setting
      default:
        return nil
    }
  }
}
