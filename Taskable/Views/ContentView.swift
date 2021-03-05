//
//  ContentView.swift
//  Taskable
//
//  Created by Rui Silva on 01/02/2021.
//

import SwiftUI

struct ContentView: View {
    
    @SceneStorage("SelectedView") var selectedView: String? //This is called so the app remembers which tab is selected.it is optional because when the app launches there's no value. IMPORTANT: We could also use @AppStorage, but in this instance @SceneStorage makes more sense as this controls invidividual instances. If this is running on an iPad and we have the app opened twice or as many times as we wanted, they'll act individually.
    
    var body: some View {
        TabView(selection: $selectedView) {
            HomeView()
                .tag(HomeView.tag)
                .tabItem {
                    Image(systemName: "house")
                    Text("Overview")
                }
            
            ProjectsView(showClosedProjects: false)
                .tag(ProjectsView.openTag)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Projects")
                }
            
//            ProjectsView(showClosedProjects: true)
//                .tag(ProjectsView.closedTag)
//                .tabItem {
//                    Image(systemName: "checkmark")
//                    Text("Closed")
//                }
//            
//            AwardsView()
//                .tag(AwardsView.tag)
//                .tabItem {
//                    Image(systemName: "rosette")
//                    Text("Awards")
//                }
        }.accentColor(Color("Tint"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
