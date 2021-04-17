//
//  UpcomingView.swift
//  HypedList
//
//  Created by Natalia  Stele on 07/04/2021.
//

import SwiftUI

struct UpcomingView: View {

    @State var showingCreatingView = false
    @ObservedObject var data = DataController.shared

    var body: some View {
        HypedEventListView(hypedEvents: data.upcomingEvents, noEventsText:             "Nothing to looking forward to 😪\n Create an event or check Discovery tab")
            .navigationTitle("Upcoming")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        showingCreatingView = true
                                    }) { Image(systemName: "calendar.badge.plus")
                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    }
                .sheet(isPresented: $showingCreatingView, content: {
                    CreateHypedEventView()
                })
            )
    }
}

struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UpcomingView()
        }
    }
}
