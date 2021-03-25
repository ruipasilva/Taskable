
//
//  ClosedProjectsEmptyView.swift
//  Taskable
//
//  Created by Rui Silva on 04/03/2021.
//

import SwiftUI

struct ClosedProjectsEmptyView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Image("empty_state_closed_projects")
                    .padding(.bottom, 20)
                Text("Projects will appear here once archived.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .frame(width: 260, alignment: .center)
                    .multilineTextAlignment(.center)
            }
            .offset(y: -20)
            .navigationBarTitle("Archive", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }.accentColor(Color("Tint"))
    }
}

struct ClosedProjectsEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        ClosedProjectsEmptyView()
    }
}
