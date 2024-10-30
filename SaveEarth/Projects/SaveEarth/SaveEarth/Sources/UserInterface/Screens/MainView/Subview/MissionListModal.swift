//
//  MissionListModal.swift
//  SaveEarth
//
//  Created by 송하민 on 6/29/24.
//

import SwiftUI

struct MissionListModal: View {
  @Environment(\.dismiss) var dismiss
  @Binding var missionList: [Mission]

  var body: some View {
    VStack {
      VStack {
        List {
          ForEach($missionList, id: \.id) { $mission in
            HStack {
              Toggle(isOn: $mission.isClear) {
                Text(mission.title)
              }
              .toggleStyle(CheckboxToggleStyle())
            }
          }
        }
      }
      Button(
        action: { dismiss() },
        label: {
          HStack {
            Spacer()
            Text("닫기")
              .foregroundStyle(.black)
              .padding(.vertical)
            Spacer()
          }
          .background(.blue)
          .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
          .padding(.horizontal)
        }
      )
    }
  }
}

#Preview {
  MissionListModal(missionList: .constant([]))
}
