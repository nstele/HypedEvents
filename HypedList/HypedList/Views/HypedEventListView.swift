//
//  HypedEventListView.swift
//  HypedList
//
//  Created by Natalia  Stele on 11/04/2021.
//

import SwiftUI

struct HypedEventListView: View {

    var hypedEvents: [HypedEvent]
    var noEventsText: String
    var isDiscover = false

    var body: some View {
        ScrollView {
            VStack {
                if (hypedEvents.isEmpty) {
                    Text(noEventsText)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                        .padding(.horizontal, 50)
                } else {
                    ForEach(hypedEvents) { event in
                        NavigationLink(
                            destination: HypeEventDetailView(hypeEvent: event, isDiscover: isDiscover)) {
                            HypeEventTileView(hypeEvent: event)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}


struct HypedEventListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                HypedEventListView(hypedEvents:[testHypeEvents1,testHypeEvents2], noEventsText: "No past events"
                )
            }
            NavigationView {
                HypedEventListView(hypedEvents: [], noEventsText: "No past events")
            }
        }
    }
}
