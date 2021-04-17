//
//  ContentView.swift
//  HypedList
//
//  Created by Natalia  Stele on 07/04/2021.
//

import SwiftUI

struct HypedListTabView: View {
    var body: some View {
        TabView {
            NavigationView {
                UpcomingView()
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Upcoming") }
            NavigationView{
                DiscoverView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Discover") }
            NavigationView{
                PastView()
            }
            .tabItem {
                Image(systemName: "gobackward")
                Text("Past") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HypedListTabView()
    }
}
