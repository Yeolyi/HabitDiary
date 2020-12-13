//
//  ColorGauge.swift
//  habitdiary
//
//  Created by SEONG YEOL YI on 2020/12/12.
//

import SwiftUI

struct LinearProgressBar: View {
    
    let color: Color
    let progress: Double
    
    init(color: Color, progress: Double) {
        self.color = color
        self.progress = max(0, min(progress, 1))
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geo.size.width , height: 10)
                    .foregroundColor(color.opacity(0.1))
                Rectangle()
                    .frame(width: CGFloat(progress) * geo.size.width, height: 10)
                    .foregroundColor(color.opacity(0.5))
                    .animation(.default)
            }
            .cornerRadius(45.0)
        }
        .frame(height: 10)
    }
}

struct LinearProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        LinearProgressBar(color: .blue, progress: 0.4)
    }
}
