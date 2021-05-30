//
//  ContentView.swift
//  HypedListTV
//
//  Created by Natalia  Stele on 19/04/2021.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var data = DataController.shared

    var body: some View {

            TabView {
                HypedEventTVListView(hypedEvents: data.upcomingEvents, noEventsText: "Nothing to show")
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Upcoming") }
                HypedEventTVListView(hypedEvents: data.discoverHypeEvents, noEventsText: "Nothing to show", isDiscover: true)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Discover") }
                HypedEventTVListView(hypedEvents: data.pastEvents, noEventsText: "Nothing to show")
                .tabItem {
                    Image(systemName: "gobackward")
                    Text("Past") }
            }
        }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
