//
//  HypedEventTVListView.swift
//  HypedListTV
//
//  Created by Natalia  Stele on 19/04/2021.
//

import SwiftUI

struct HypedEventTVListView: View {

    var hypedEvents: [HypedEvent]
    var noEventsText: String
    var isDiscover = false
    
    var body: some View {
        if (hypedEvents.isEmpty) {
            Text(noEventsText)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.top, 20)
                .padding(.horizontal, 50) }
        else {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(hypedEvents) { event in
                        Button(action: {})  {
                            HypedEventTVTileView(hypeEvent: event)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .contextMenu(menuItems: {
                            if isDiscover {
                                Button(action: {
                                    DataController.shared.addFromDiscover(hypedEvent: event)
                                })  {
                                    Text("Add")
                                }
                            } else {
                                Button(action: {
                                    DataController.shared.deleteHypeEvent(hypedEvent: event)
                                })  {
                                    Text("Delete")
                                }
                            }

                        })
                    }
                }
            }
        }
    }
}

struct HypedEventTVListView_Previews: PreviewProvider {
    static var previews: some View {
        HypedEventTVListView(hypedEvents: [testHypeEvents1, testHypeEvents2], noEventsText: "No events")
    }
}
