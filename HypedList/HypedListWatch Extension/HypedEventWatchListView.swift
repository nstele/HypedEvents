//
//  HypedEventWatchListView.swift
//  HypedListWatch Extension
//
//  Created by Natalia  Stele on 17/04/2021.
//

import SwiftUI

struct HypedEventWatchListView: View {
    
    var hypedEvents: [HypedEvent]
    
    var body: some View {
        if hypedEvents.count > 0 {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(hypedEvents) { event in
                        HStack {
                            Spacer()
                            VStack {
                                Text(event.title)
                                    .font(.headline)
                                    .padding(.top, 10)

                                Text("\(event.dateFromNow().capitalized) on \(event.dateAsString())")
                                    .padding(.bottom, 10)
                            }
                            .foregroundColor(!event.color.isDarkColor ? .white : .black)
                            
                            Spacer()
                        }
                        .background(event.color)
                        .cornerRadius(5)
                    }
                }
            }
            
        } else {
            Text("Nothing to look forward to, please add things through the app")
        }
    }
}

struct HypedEventWatchListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HypedEventWatchListView(hypedEvents: [testHypeEvents1, testHypeEvents2])
            HypedEventWatchListView(hypedEvents: [])
        }
    }
}


extension Color {
    var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r,g,b,a) = (0,0,0,0)
        UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r +  0.7152 * g + 0.0722 * b
        return lum > 0.5
    }
}


