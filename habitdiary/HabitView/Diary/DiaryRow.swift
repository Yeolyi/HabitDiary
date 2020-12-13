//
//  DiaryRow.swift
//  habitdiary
//
//  Created by SEONG YEOL YI on 2020/12/13.
//

import SwiftUI

struct DiaryRow: View {
    
    @Binding var activeSheet: ActiveSheet?
    @Binding var expanded: Bool
    @ObservedObject var habit: HabitInfo
    let selectedDate: Date
    
    var body: some View {
        VStack {
            HStack {
                Text("일기")
                    .font(.system(size: 20, weight: .bold))
                Spacer()
            }
            if !expanded && habit.diary[selectedDate.dictKey] != nil {
                HStack {
                    Text(habit.diary[selectedDate.dictKey]!)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.leading, 5)
                        .foregroundColor(.gray)
                        .padding(8)
                    Spacer()
                }
            }
            if !expanded && habit.diary[selectedDate.dictKey] == nil {
                HStack {
                    Text("오늘의 일기장이 비어있습니다.")
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.leading, 5)
                        .foregroundColor(.gray)
                        .padding(8)
                    Spacer()
                }
            }
            if expanded {
                DiaryExpanded(habit: habit)
            }
        }
        .rowBackground()
    }
}

/*
struct DiaryRow_Previews: PreviewProvider {
    static var previews: some View {
        DiaryRow()
    }
}
*/
