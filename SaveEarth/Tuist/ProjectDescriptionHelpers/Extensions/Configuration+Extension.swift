//
//  Configuration+Extension.swift
//  Packages
//
//  Created by 송하민 on 7/11/24.
//

import ProjectDescription

public extension Configuration {
  
  enum ConfigScheme: ConfigurationName, CaseIterable {
    case debug = "Debug"
    case release = "Release"
  }
  
  static func configure(configurations: [ConfigScheme]) -> [Configuration] {
    return configurations.map { $0.rawValue }.map { configName -> Configuration in
      switch configName {
        case .release:
            return .release(
              name: configName,
              settings: .init(uniqueKeysWithValues: [("URL_SCHEMES", "saveearth")]),
              xcconfig: .xcconfigPath(configName.rawValue)
            )
        
        case .debug:
          fallthrough
          
        default:
          return .debug(
            name: configName,
            settings: .init(uniqueKeysWithValues: [("URL_SCHEMES", "saveearth-dev")]),
            xcconfig: .xcconfigPath(configName.rawValue)
          )
      }
    }
  }
  
}
