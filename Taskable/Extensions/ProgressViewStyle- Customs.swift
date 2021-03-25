//
//  ProgressViewStyle- Customs.swift
//  Taskable
//
//  Created by Rui Silva on 15/03/2021.
//

import Foundation
import SwiftUI

struct GaugeProgressStyle: ProgressViewStyle {
    
    @ObservedObject var project: Project
    
    var strokeWidth = 4
    
    var rotation: Angle {
        Angle(radians: .pi) + Angle(radians: .pi / 2)
    }
    
    func makeBody(configuration: Configuration) -> some View {
        return ZStack {
            Circle()
                .rotation(rotation)
                .trim(from: 0, to: 1)
                .stroke(Color(project.projectColor).opacity(0.2), style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
            
            Circle()
                .rotation(rotation)
                .trim(from: 0, to: CGFloat(project.completionAmount))
                .stroke(Color(project.projectColor), style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
        }
    }
}
