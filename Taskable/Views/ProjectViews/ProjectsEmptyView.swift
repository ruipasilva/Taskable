//
//  ProjectsEmptyView.swift
//  Taskable
//
//  Created by Rui Silva on 07/02/2021.
//

import SwiftUI

struct ProjectsEmptyView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("empty_state_projects")
                .padding(.bottom, 20)
            Text("Tap ‘+’ to add your first project.")
                .font(.body)
                .foregroundColor(.secondary)
                .frame(width: 260, alignment: .center)
                .multilineTextAlignment(.center)
            
        }
        .offset(y: -20)
    }
}

struct ProjectsEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsEmptyView()
    }
}
