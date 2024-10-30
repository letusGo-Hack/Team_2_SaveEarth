//
//  QuestFloatingButton.swift
//  SaveEarth
//
//  Created by 송하민 on 6/29/24.
//

import SwiftUI

struct QuestFloatingButton: View {

  @Binding var missionList: [Mission]

  @State var isPresentedModal: Bool = false

  var body: some View {
    Button {
      isPresentedModal.toggle()
    } label: {
      Text("\(missionList.filter { !$0.isClear }.count)개의 퀘스트가 있어요!") // 가제목
        .padding()
    }
    .foregroundStyle(.white)
    .background(.red)
    .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
    .padding(.init([.trailing, .leading]), 20)
    .sheet(isPresented: $isPresentedModal) {
      MissionListModal(missionList: $missionList)
        .presentationDetents([.height(260)])
    }
    .onChange(of: missionList, initial: false) { oldValue, newValue in
      if newValue.allSatisfy(\.isClear) {
        isPresentedModal = false
      }
    }
  }
}

#Preview {
  QuestFloatingButton(missionList: .constant([]))
}
