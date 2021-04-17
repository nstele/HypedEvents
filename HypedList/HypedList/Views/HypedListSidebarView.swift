//
//  HypedListSidebarView.swift
//  HypedListiOS
//
//  Created by Natalia  Stele on 15/04/2021.
//

import SwiftUI

struct HypedListSidebarView: View {
    
    @State var showingCreatingView = false

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: UpcomingView()) {
                    Label("Upcoming", systemImage: "calendar")
                }

                NavigationLink(destination: DiscoverView()) {
                    Label("Discover", systemImage: "magnifyingglass")
                }

                NavigationLink(destination: PastView()) {
                    Label("Past", systemImage: "gobackward")
                }
            }
            .listStyle(SidebarListStyle())  .navigationTitle("Hyped  List")
            .overlay(bottomSideBarView, alignment: .bottom)

            UpcomingView()
            Text("Select an event")
        }
    }

    var bottomSideBarView: some View {
        VStack {
            Divider()
            Button(action: {
                showingCreatingView = true
            }, label: {
                Label("Create Event", systemImage: "calendar.badge.plus")
            })
            .sheet(isPresented: $showingCreatingView, content: {
                CreateHypedEventView()
            })
        }
    }
}

struct HypedListSidebarView_Previews: PreviewProvider {
    static var previews: some View {
        HypedListSidebarView()
    }
}
