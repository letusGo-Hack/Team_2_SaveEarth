//
//  ContentView.swift
//  SaveEarth
//
//  Created by 김용우 on 6/29/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var weatherManager: WeatherManager
    @Query(sort: \DayInfo.date) var dayInfoCollection: [DayInfo]
    
    @State var desiredLatitude: CGFloat = 76.571640
    @State var desiredLongitude: CGFloat = -41.666646
    
    @State private var showQuestModal: Bool = false
    @State private var allQuestCheck: Bool = false
    
    @State var current: Double = 0.0
    @State var average: Double = 0.0
    
    @State private var quests: [Quest] = [
        .init(id: UUID(), isChecked: false, questTitle: "페트병 분리수거 하기 🫡"),
        .init(id: UUID(), isChecked: false, questTitle: "에어컨 1도 낮추기 😎"),
        .init(id: UUID(), isChecked: false, questTitle: "텀블러 사용하기 😙"),
        .init(id: UUID(), isChecked: false, questTitle: "종이컵 쓰지 않기 😀")
    ]
    
    @State var isSetup: Bool = false
    @State var completion: Float = 0.0
    
    var body: some View {
        ZStack {
            MapView(
                lat: $desiredLatitude,
                lon: $desiredLongitude, 
                isFire: completion != 1
            )
            
            TemperatureGradient(complete: $completion)
                .ignoresSafeArea()
            if isSetup {
                if showQuestModal {
                    QuestModalView(isPresented: $showQuestModal) {
                        QuestView(quests: $quests, isPresented: $showQuestModal)
                    }
                    .transition(.move(edge: .bottom))
                    .animation(.default, value: showQuestModal)
                    .ignoresSafeArea(edges: .bottom)
                } else {
                    if self.quests.map({ $0.isChecked }).allSatisfy({ $0 == true }) {
                        CompleteQuestView()
                            .transition(CompleteRotatingTransition())
                    }
                }
            } else {
                ProgressView()
            }
        }
        .animation(.spring(), value: showQuestModal)
        .overlay {
            VStack {
                Text(completion != 1 ? "뜨거운 지구를 구해주세요!! 😱" : "오늘도 지구를 조금 살려냈어요!")
                    .font(.title2)
                    .padding(.bottom)
                VStack(alignment: .leading) {
                    Text("Temperature 🌡️")
                    Text("Current: " + String(format: "%.2f", current) + "℃")
                    Text("Average: " + String(format: "%.2f", average) + "℃")
                }
                .font(.title)
                .padding(.leading)
                .padding(.bottom, 60)
                Spacer()
                if !self.showQuestModal &&
                    !self.quests.map({ $0.isChecked }).allSatisfy({ $0 == true }) {
                    QuestFloatingButton(numberOfQuests: UInt(self.quests.count)) {
                        self.showQuestModal = true
                    }
                    .transition(AppearingTransition())
                }
            }
        }
        .animation(.default, value: !showQuestModal)
        .onChange(of: quests) { oldValue, newValue in
            let isCheckedCount = newValue.filter({ $0.isChecked }).count
            completion = Float(isCheckedCount) / Float(quests.count)
            if isCheckedCount == newValue.count {
                showQuestModal.toggle()
            }
        }
        .task {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let currentDate = Date.now
            let formattedDate = dateFormatter.string(from: currentDate)
            
            if let lastDate: String = dayInfoCollection.last?.date,
               lastDate != formattedDate {
                do {
                    let fetchedData = try await weatherManager.fetchHistoricalTemperature(
                        location: .init(
                            latitude: desiredLatitude,
                            longitude: desiredLongitude
                        )
                    )

                )
                
                // TODO: SwiftData 개체 생성
                
                Task { @MainActor in
                    current = fetchedData?.currentTemperature ?? 0.0
                    average = fetchedData?.historicTemperature ?? 0.0
                    
                    isSetup.toggle()
                }
            }
        }
    }
    
    func makeMissionList(
        count: Int
    ) -> [Mission] {
        var questList: [Quest] = [
            .init(questTitle: "페트병 분리수거 하기"),
            .init(questTitle: "에어컨 1도 낮추기"),
            .init(questTitle: "오늘 하루 텀블러 사용하기"),
            .init(questTitle: "종이컵 사용하지 않기"),
            .init(questTitle: "대중교통 이용하기"),
            .init(questTitle: "낮에는 전등 끄기"),
            .init(questTitle: "사용하지 않는 콘센트 선 뽑아 놓기")
        ]
        var missionList = [Mission]()
        
        while missionList.count == count {
            
            // 배열에서 랜덤 인덱스 선택
            let randomIndex = Int.random(in: 0..<questList.count)
            let randomItem = questList[randomIndex]
            if missionList.contains(where: { $0.title == randomItem.questTitle }) {
                continue
            }
            missionList.append(
                .init(
                    title: randomItem.questTitle,
                    isClear: randomItem.isChecked
                )
            )
        }
        
        return missionList
    }
    
    
    
}

#Preview {
    ContentView()
}
