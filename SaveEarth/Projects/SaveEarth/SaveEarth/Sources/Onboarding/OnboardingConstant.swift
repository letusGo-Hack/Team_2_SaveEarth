//
//  OnboardingConstant.swift
//  SaveEarth
//
//  Created by 구본의 on 10/13/24.
//

import Foundation

enum OnboardingConstant {
  static let onboardingData: [OnboardingModel] = [
    OnboardingModel(
      image: "bell",
      title: "Push Notifications",
      contents: "Enable notifications to stay up to date with our app.",
      buttonTitle: "현재는 어떤가요?"
    ),
    OnboardingModel(
      image: "bookmark",
      title: "Bookmarks",
      contents: "Save your favorite content for easy access later.",
      buttonTitle: "무엇이 있나요?"
    ),
    OnboardingModel(
      image: "airplane",
      title: "Travel Mode",
      contents: "Access your content offline while traveling.",
      buttonTitle: "아.. 그렇군요"
    ),
    OnboardingModel(
      image: "house",
      title: "Welcome Home",
      contents: "You're all set! Enjoy using our app.",
      buttonTitle: "지구를 지키러 갈께요"
    )
  ]
}
