//
//  DiscoverView.swift
//  HypedList
//
//  Created by Natalia  Stele on 11/04/2021.
//

import SwiftUI

struct DiscoverView: View {

    @ObservedObject var data = DataController.shared
    
    var body: some View {
        HypedEventListView(hypedEvents: data.discoverHypeEvents.sorted {$0.date > $1.date}, noEventsText: "No events have passet yet 😪\n Yout should add more things!", isDiscover: true)
            .navigationTitle("Discover")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        data.getDiscoverEvents()
                                    }) { Image(systemName: "arrow.clockwise")
                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    }

            )
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
