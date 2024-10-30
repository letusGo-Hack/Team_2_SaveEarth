//
//  OnboardingPageView.swift
//  SaveEarth
//

import SwiftUI

struct OnboardingPageView: View {

  // MARK: - Property

  let model: OnboardingModel

  // MARK: - Body

  var body: some View {
    VStack {
      Image(systemName: model.image)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 150, height: 150)
        .padding()

      Text(model.title)
        .font(.system(size: 32))
        .foregroundStyle(DesignSystem.AppColor.appWhite)
        .padding()

      Text(model.contents)
        .multilineTextAlignment(.center)
        .font(.system(size: 16))
        .foregroundStyle(DesignSystem.AppColor.appWhiteSubTitle)
        .padding(.horizontal, 40)
    }
  }
}

#Preview {
  OnboardingPageView(
    model: .init(
      image: "bell",
      title: "Push Notifications",
      contents: "Enable notifications to stay up to date with our app.",
      buttonTitle: "현재는 어떤가요?"
    )
  )
}
