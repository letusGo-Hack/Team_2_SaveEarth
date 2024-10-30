//
//  Project+Application.swift
//  Packages
//
//  Created by 송하민 on 7/11/24.
//

import ProjectDescription

extension Project {
  
  public static func app(
    name: String,
    platform: Platform,
    dependencies: [TargetDependency],
    testDependencies: [TargetDependency]
  ) -> Project {
    
    let targets = makeAppTargets(
      name: name,
      scripts: [
        .prebuildScript(utility: .swiftGen, name: "Gen"),
        .prebuildScript(utility: .swiftLint, name: "Lint")
      ],
      dependencies: dependencies,
      testDependencies: testDependencies
    )
    
    return .init(name: name, targets: targets, resourceSynthesizers: [])
  }
  
  // MARK: - Targets
  
  private static func makeAppTargets(
    name: String,
    destinations: Destinations = .iOS,
    productName: String? = productName,
    bundleId: String = bundleId,
    deploymentTargets: DeploymentTargets? = deployTarget,
    scripts: [TargetScript],
    dependencies: [TargetDependency],
    testDependencies: [TargetDependency],
    coreDataModels: [CoreDataModel] = []
  ) -> [Target] {
    
    let mainTarget: Target = .target(
      name: name,
      destinations: destinations,
      product: .app,
      productName: productName,
      bundleId: bundleId,
      deploymentTargets: deploymentTargets,
      infoPlist: .extendingDefault(with: [
        "CFBundleDevelopmentRegion": "ko_KR",
        "CFBundleShortVersionString": "1.0.0",
        "CFBundleVersion": "1",
        "UILaunchStoryboardName": "LaunchScreen",
        "CFBundleIconName": "AppIcon",
        "NSAppTransportSecurity": [
          "NSAllowsArbitraryLoads": true
        ],
        "CFBundleURLTypes": [
          [
            "CFBundleTypeRole": "Editor",
            "CFBundleURLSchemes": ["$(URL_SCHEMES)"]
          ]
        ]
      ]),
      sources: ["SaveEarth/Sources/**"],
      resources: ["SaveEarth/Resources/**"],
      entitlements: .file(path: .entitlementPath("SaveEarth")),
      scripts: scripts,
      dependencies: dependencies,
      settings: .settings(base: [:], configurations: Configuration.configure(configurations: Configuration.ConfigScheme.allCases)),
      coreDataModels: coreDataModels
    )
    
    let testTarget: Target = .target(
      name: "\(name)Tests",
      destinations: destinations,
      product: .unitTests,
      bundleId: "\(bundleId)Tests",
      sources: ["SaveEarthTests/Tests/**"],
      resources: [],
      scripts: scripts,
      dependencies: testDependencies
    )
    
    return [mainTarget, testTarget]
  }
}
