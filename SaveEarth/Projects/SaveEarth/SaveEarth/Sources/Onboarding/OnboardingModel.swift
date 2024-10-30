//
//  OnboardingModel.swift
//  SaveEarth
//

import Foundation

struct OnboardingModel: Hashable, Equatable {

  // MARK: - Property

  let image: String
  let title: String
  let contents: String
  let buttonTitle: String

  // MARK: - Initialize

  init(
    image: String,
    title: String,
    contents: String,
    buttonTitle: String
  ) {
    self.image = image
    self.title = title
    self.contents = contents
    self.buttonTitle = buttonTitle
  }
}
