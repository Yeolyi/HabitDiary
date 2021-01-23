//
//  CaptureCalendar.swift
//  Filin
//
//  Created by SEONG YEOL YI on 2021/01/20.
//

import SwiftUI

struct CaptureCalendar: View {
    
    @Binding var showCalendarSelect: Bool
    @Binding var isEmojiView: Bool
    @Binding var selectedDate: Date
    @Binding var isExpanded: Bool
    let habit1: FlHabit
    let habit2: FlHabit
    let habit3: FlHabit
    
    @EnvironmentObject var appSetting: AppSetting
    @Environment(\.colorScheme) var colorScheme
    
    var habitsWrapped: [FlHabit?] {
        [
            habit1.requiredSec == -1 ? nil : habit1,
            habit2.requiredSec == -1 ? nil : habit2,
            habit3.requiredSec == -1 ? nil : habit3
        ]
    }
    
    var color: Color {
        if habitsWrapped.compactMap({$0}).isEmpty {
            return ThemeColor.mainColor(colorScheme)
        } else {
            return habitsWrapped.compactMap({$0})[0].color
        }
    }
    
    init(showCalendarSelect: Binding<Bool>, isEmojiView: Binding<Bool>, isExpanded: Binding<Bool>, selectedDate: Binding<Date>,
         habit1: FlHabit, habit2: FlHabit? = nil, habit3: FlHabit? = nil) {
        self._showCalendarSelect = showCalendarSelect
        self._isEmojiView = isEmojiView
        self._isExpanded = isExpanded
        self._selectedDate = selectedDate
        let nilHabit = FlHabit(name: "Nil")
        nilHabit.requiredSec = -1
        self.habit1 = habit1
        self.habit2 = habit2 == nil ? nilHabit : habit2!
        self.habit3 = habit3 == nil ? nilHabit : habit3!
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if showCalendarSelect {
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .frame(maxWidth: .infinity)
            } else {
                HStack {
                    VStack {
                        HStack(alignment: .bottom, spacing: 3) {
                            Text(habit1.name)
                                .foregroundColor(color)
                                .headline()
                            Spacer()
                            Text(selectedDate.localizedYearMonth)
                                .foregroundColor(color)
                                .bodyText()
                        }
                    }
                    Spacer()
                }
                .padding(.bottom, 15)
                VStack(spacing: 0) {
                    VStack {
                        if isExpanded {
                            ForEach(1..<selectedDate.weekNuminMonth(isMondayStart: appSetting.isMondayStart) + 1, id: \.self) { week in
                                if isEmojiView && !habitsWrapped.compactMap({$0}).isEmpty {
                                    EmojiCalendarRow(week: week, isExpanded: isExpanded, selectedDate: $selectedDate, habit: habitsWrapped.compactMap({$0})[0])
                                } else {
                                    HStack(spacing: 8) {
                                        ForEach(selectedDate.containedWeek(week: week, from: appSetting.isMondayStart ? 2 : 1), id: \.self) { date in
                                            CircleProgress(
                                                CalendarRingDesign.getRingTuple(
                                                    at: date, habits: habitsWrapped, selectedDate: selectedDate, colorScheme: colorScheme
                                                )) {
                                                Text(appSetting.mainDate.dictKey == date.dictKey ? "✓" : String(date.day))
                                                    .foregroundColor(
                                                        CalendarRingDesign.textColor(
                                                                at: date, habits: habitsWrapped, selectedDate: selectedDate,
                                                            isExpanded: isExpanded, colorScheme: colorScheme)
                                                    )
                                                    .bodyText()
                                            }
                                        }
                                    }
                                    .padding(.bottom, 10)
                                }
                            }
                        } else {
                            if isEmojiView && !habitsWrapped.compactMap({$0}).isEmpty {
                                EmojiCalendarRow(week: selectedDate.weekNum(startFromMon: appSetting.isMondayStart),
                                                 isExpanded: isExpanded, selectedDate: $selectedDate, habit: habitsWrapped.compactMap({$0})[0])
                            } else {
                                HStack(spacing: 8) {
                                    ForEach(selectedDate.containedWeek(week:
                                                                        selectedDate.weekNum(startFromMon: appSetting.isMondayStart), from: appSetting.isMondayStart ? 2 : 1), id: \.self) { date in
                                        CircleProgress(
                                            CalendarRingDesign.getRingTuple(
                                                at: date, habits: habitsWrapped, selectedDate: selectedDate, colorScheme: colorScheme
                                            )
                                        ) {
                                            Text(appSetting.mainDate.dictKey == date.dictKey ? "✓" : String(date.day))
                                                .foregroundColor(
                                                    CalendarRingDesign.textColor(
                                                            at: date, habits: habitsWrapped, selectedDate: selectedDate,
                                                        isExpanded: isExpanded, colorScheme: colorScheme)
                                                )
                                                .bodyText()
                                        }
                                    }
                                }
                                .padding(.bottom, 10)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CaptureCalendar_Previews: PreviewProvider {
    static var previews: some View {
        CaptureCalendar(showCalendarSelect: .constant(false),
                        isEmojiView: .constant(false), isExpanded: .constant(true),
                        selectedDate: .constant(Date()), habit1: DataSample.shared.habit1
        )
        .environmentObject(AppSetting())
        .rowBackground()
    }
}
