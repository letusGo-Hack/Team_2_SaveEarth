//
//  OnboardingView.swift
//  SaveEarth
//

import SwiftUI

import ComposableArchitecture

struct OnboardingView: View {

  // MARK: - Constant

  private enum Constant {
    static let horizontalPadding: CGFloat = 20
  }

  // MARK: Property

  @AppStorage(AppStorageKeys.onboarding) var isOnboarding: Bool = false
  @State private var currentPage: Int = 0
  var isLastPage: Bool {
    currentPage == OnboardingConstant.onboardingData.count - 1
  }

  // MARK: - Body

  var body: some View {
    ZStack(alignment: .bottom) {
      DesignSystem.AppColor.appPrimary3
        .edgesIgnoringSafeArea(.all)

      TabView(selection: $currentPage) {
        ForEach(OnboardingConstant.onboardingData.indices, id: \.self) { index in
          ZStack(alignment: .bottom) {
            OnboardingPageView(model: OnboardingConstant.onboardingData[index])
              .tag(index)
          }
        }
      }
      .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
      .indexViewStyle(.page(backgroundDisplayMode: .never))
      .animation(.easeInOut, value: currentPage)

      VStack {
        PageIndicator(
          currentPage: currentPage,
          pageCount: OnboardingConstant.onboardingData.count
        )
        .padding(.bottom)

        AppButton(
          title: OnboardingConstant.onboardingData[currentPage].buttonTitle,
          style: isLastPage ? .primary : .default
        ) {
          if !isLastPage {
            currentPage += 1
          } else {
            isOnboarding = true
          }
        }
        .padding(.horizontal, Constant.horizontalPadding)
      }
    }
  }
}

#Preview {
  OnboardingView()
}
