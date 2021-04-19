//
//  ContentView.swift
//  HypedListWatch Extension
//
//  Created by Natalia  Stele on 17/04/2021.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var data = WatchToPhoneDataController.shared

    var body: some View {
        HypedEventWatchListView(hypedEvents: data.hypedEvents)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
