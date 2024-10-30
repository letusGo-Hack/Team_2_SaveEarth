//
//  AppButton.swift
//  SaveEarth
//

import SwiftUI

struct AppButton: View {

  // MARK: - Constant

  private enum Constant {
    static let height: CGFloat = 48
    static let radius: CGFloat = 24
  }

  enum Style {
    case `default`
    case primary
  }

  // MARK: - Property

  private let title: String
  private let style: Style
  private let action: () -> Void

  private var foregroundColor: Color {
    switch style {
    case .default:
      DesignSystem.AppColor.appPrimary2
    case .primary:
      DesignSystem.AppColor.appWhite
    }
  }

  private var backgroudColor: Color {
    switch style {
    case .default:
      DesignSystem.AppColor.appWhite
    case .primary:
      DesignSystem.AppColor.appPrimary1
    }
  }

  // MARK: - Initialize

  init(
    title: String,
    style: Style,
    action: @escaping () -> Void
  ) {
    self.title = title
    self.style = style
    self.action = action
  }

  // MARK: - Body

  var body: some View {
    Button(
      action: action,
      label: {
        Text(title)
          .foregroundColor(foregroundColor)
          .font(.system(size: 16, weight: .bold))
          .frame(height: Constant.height)
          .frame(maxWidth: .infinity)
          .background(backgroudColor)
          .clipShape(.rect(cornerRadius: Constant.radius))
      }
    )
  }
}
