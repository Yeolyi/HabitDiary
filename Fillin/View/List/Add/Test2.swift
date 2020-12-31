//
//  Test2.swift
//  habitdiary
//
//  Created by SEONG YEOL YI on 2020/12/13.
//

import SwiftUI

struct DateSection: View {
    @Binding var habitType: HabitCycleType
    @Binding var dayOfTheWeek: [Int]
    var body: some View {
        HabitAddBadgeView(title: "Repeat".localized, imageName: "calendar") {
            HStack {
                Text("Choose the day of the week to proceed with the goal.".localized)
                    .bodyText()
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding(.leading, DesignValues.horizontalBorderPadding)
            DayOfWeekSelector(dayOfTheWeek: $dayOfTheWeek)
                .padding(.top, 21)
        }
    }
}

struct Test2_Previews: PreviewProvider {
    static var previews: some View {
        DateSection(habitType: .constant(.weekly), dayOfTheWeek: .constant([]))
    }
}
