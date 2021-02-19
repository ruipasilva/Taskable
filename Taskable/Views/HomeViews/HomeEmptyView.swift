//
//  HomeEmptyView.swift
//  Taskable
//
//  Created by Rui Silva on 15/02/2021.
//

import SwiftUI

struct HomeEmptyView: View {
    var body: some View {
        Text("Please add projects and items to find more info here.")
            .italic()
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
    }
}

struct HomeEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        HomeEmptyView()
    }
}
