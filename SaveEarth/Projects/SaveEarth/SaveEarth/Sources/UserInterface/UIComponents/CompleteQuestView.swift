//
//  CompleteQuestView.swift
//  SaveEarth
//
//  Created by 송하민 on 6/29/24.
//

import SwiftUI

struct CompleteQuestView: View {
    var body: some View {
        Image(systemName: "hand.thumbsup.circle.fill")
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .foregroundColor(.green)
            .transition(CompleteRotatingTransition())
    }
}

#Preview {
    CompleteQuestView()
}
