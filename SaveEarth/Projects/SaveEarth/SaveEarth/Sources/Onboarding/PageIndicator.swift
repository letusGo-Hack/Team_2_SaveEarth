//
//  PageIndicator.swift
//  SaveEarth
//

import SwiftUI

struct PageIndicator: View {

  // MARK: - Constant

  private enum Constant {
    static let spacing: CGFloat = 4
    static let cornerRadius: CGFloat = 2
    static let originSize: CGSize = .init(width: 10, height: 4)
    static let selectedSize: CGSize = .init(width: 48, height: 4)
  }

  let currentPage: Int
  let pageCount: Int

  var body: some View {
    HStack(spacing: Constant.spacing) {
      ForEach(0..<pageCount, id: \.self) { index in
        RoundedRectangle(cornerRadius: Constant.cornerRadius)
          .fill(currentPage == index ? DesignSystem.AppColor.appWhite : Color.gray)
          .frame(
            width: currentPage == index ? Constant.selectedSize.width : Constant.originSize.width,
            height: currentPage == index ? Constant.selectedSize.height : Constant.originSize.height
          )
      }
    }
  }
}
