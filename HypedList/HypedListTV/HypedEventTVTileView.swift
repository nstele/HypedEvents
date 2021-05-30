//
//  HypedEventTVTileView.swift
//  HypedListTV
//
//  Created by Natalia  Stele on 19/04/2021.
//

import SwiftUI

struct HypedEventTVTileView: View {
    @ObservedObject var hypeEvent: HypedEvent
    var isDiscover = false

    var body: some View {
        VStack(spacing: 0) {
            if let eventImage = hypeEvent.image() {
                HStack {
                    Spacer()
                eventImage
                    .resizable()
                    .aspectRatio(contentMode : .fit)
                    Spacer()
                }
                .background(hypeEvent.color)
            } else {
                hypeEvent.color
                    .aspectRatio(contentMode: .fit)
            }

            Text(hypeEvent.title)
                .font(.largeTitle)
                .padding(.top,20)
                .padding(.horizontal,60)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)

            Text("\(hypeEvent.dateFromNow().capitalized) on \(hypeEvent.dateAsString())")
                .padding(.bottom, 10)
                .padding(.top, 10)
                .padding(.horizontal, 20)
                .font(.title)
                .foregroundColor(.black)


        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct HypedEventTVTileView_Previews: PreviewProvider {
    static var previews: some View {
        HypedEventTVTileView(hypeEvent: testHypeEvents2)
    }
}
