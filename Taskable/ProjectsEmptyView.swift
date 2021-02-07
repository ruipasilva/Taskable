//
//  ProjectsEmptyView.swift
//  Taskable
//
//  Created by Rui Silva on 07/02/2021.
//

import SwiftUI

struct ProjectsEmptyView: View {
    var body: some View {
        Text("Please select something grom the menu to begin")
            .italic()
            .foregroundColor(.secondary)
    }
}

struct ProjectsEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsEmptyView()
    }
}
