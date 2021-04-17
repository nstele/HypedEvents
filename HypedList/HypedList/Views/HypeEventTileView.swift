//
//  HypeEventTileView.swift
//  HypedList
//
//  Created by Natalia  Stele on 10/04/2021.
//

import SwiftUI

struct HypeEventTileView: View {

    @ObservedObject var hypeEvent: HypedEvent

    var body: some View {
        VStack(spacing: 0) {
            if let eventImage = hypeEvent.image() {
                eventImage
                    .resizable()
                    .aspectRatio(contentMode : .fit)
            }
            Rectangle()
                .foregroundColor(hypeEvent.color)
                .frame(height: 10)

            HStack {
                Spacer()
                Text(hypeEvent.title)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                    .padding()
            }
            .background(Color.white)


            HStack {
                Image(systemName: "calendar")
                Text(hypeEvent.dateAsString())
                Spacer()
                Text(hypeEvent.dateFromNow())
                Image(systemName: "clock.fill")
            }
            .font(.title3)
            .padding(.horizontal)
            .padding(.bottom,20)
            .background(Color.white)

        }
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
    }

}

struct HypeEventTileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HypeEventTileView(hypeEvent: testHypeEvents1)
                .previewLayout(.sizeThatFits)
            HypeEventTileView(hypeEvent: testHypeEvents2)
                .previewLayout(.sizeThatFits)

        }
    }
}
