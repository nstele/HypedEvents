//
//  PastView.swift
//  HypedList
//
//  Created by Natalia  Stele on 11/04/2021.
//

import SwiftUI

struct PastView: View {

    @ObservedObject var data = DataController.shared

    var body: some View {
        HypedEventListView(hypedEvents: data.pastEvents, noEventsText: "No events have passet yet 😪\n Yout should add more things!")
            .navigationTitle("Past")
    }
}

struct PastView_Previews: PreviewProvider {
    static var previews: some View {
        PastView()
    }
}
