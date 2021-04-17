//
//  HypeEventDetailView.swift
//  HypedList
//
//  Created by Natalia  Stele on 11/04/2021.
//

import SwiftUI

struct HypeEventDetailView: View {

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ObservedObject var hypeEvent: HypedEvent
    @State var showingCreatingView = false
    @State var deleted = false
    var isDiscover = false
    
    var body: some View {
        if deleted {
            Text("Event deleted")
        } else {
            if (horizontalSizeClass == .regular) {
                regular
            } else {
                compact
            }
        }
    }


    var regular: some View {
        VStack {
            VStack(spacing: 0) {
                if let eventImage = hypeEvent.image() {
                    eventImage
                        .resizable()
                        .aspectRatio(contentMode : .fit)
                } else {
                    hypeEvent.color
                        .aspectRatio(contentMode: .fit)
                }

                Text(hypeEvent.title)
                    .font(.largeTitle)
                    .padding(.top, 10)

                Text("\(hypeEvent.dateFromNow().capitalized) on \(hypeEvent.dateAsString())")
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .font(.title)

            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(40)


            HStack {

                if hypeEvent.validURL() != nil {
                    Button(action: {
                        UIApplication.shared.open(hypeEvent.validURL()!)
                    }) {
                        HypedEventDetailsButtonViewRegular(text: "Visite Site", backgroundColor: .orange, imageName: "link")
                    }
                }

                if isDiscover {
                    Button(action: {
                        DataController.shared.addFromDiscover(hypedEvent: hypeEvent)
                    }) {
                        HypedEventDetailsButtonViewRegular(text: hypeEvent.hasBeenAdded ? "Added" : "Add", backgroundColor: .green, imageName: "plus.circle")
                    }
                    .disabled(hypeEvent.hasBeenAdded)
                    .opacity(hypeEvent.hasBeenAdded ? 0.5 : 1.0)

                } else {
                    Button(action: {
                        showingCreatingView = true
                    }) {
                        HypedEventDetailsButtonViewRegular(text: "Edit", backgroundColor: .yellow, imageName: "pencil.circle")
                    }
                    .sheet(isPresented: $showingCreatingView, content: {
                        CreateHypedEventView(event: hypeEvent)
                    })

                    Button(action: {
                        deleted = true
                        DataController.shared.deleteHypeEvent(hypedEvent: hypeEvent)
                    }) {
                        HypedEventDetailsButtonViewRegular(text: "Delete", backgroundColor: .red, imageName: "trash")
                    }
                }
            }
            .padding()
        }
        .padding(40)
    }

    var compact: some View {
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
            Text("\(hypeEvent.dateFromNow().capitalized) on \(hypeEvent.dateAsString())")
                .font(.title2)
            Spacer()

            if hypeEvent.validURL() != nil {
                Button(action: {
                    UIApplication.shared.open(hypeEvent.validURL()!)
                }) {
                    HypedEventDetailsButtonView(text: "Visite Site", backgroundColor: .orange, imageName: "link")
                }
            }

            if isDiscover {
                Button(action: {
                    DataController.shared.addFromDiscover(hypedEvent: hypeEvent)
                }) {
                    HypedEventDetailsButtonView(text: hypeEvent.hasBeenAdded ? "Added" : "Add", backgroundColor: .green, imageName: "plus.circle")
                }
                .disabled(hypeEvent.hasBeenAdded)
                .opacity(hypeEvent.hasBeenAdded ? 0.5 : 1.0)

            } else {
                Button(action: {
                    showingCreatingView = true
                }) {
                    HypedEventDetailsButtonView(text: "Edit", backgroundColor: .yellow, imageName: "pencil.circle")
                }
                .sheet(isPresented: $showingCreatingView, content: {
                    CreateHypedEventView(event: hypeEvent)
                })

                Button(action: {
                    deleted = true
                    DataController.shared.deleteHypeEvent(hypedEvent: hypeEvent)
                }) {
                    HypedEventDetailsButtonView(text: "Delete", backgroundColor: .red, imageName: "trash")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }


}

struct HypedEventDetailsButtonView: View {
    var text: String
    var backgroundColor: Color
    var imageName: String

    var body: some View {
        HStack {
            Spacer()
            Image(systemName: imageName)
            Text(text)
            Spacer()
        }
        .font(.title)
        .padding(12)
        .background(backgroundColor)
        .foregroundColor(.white)
        .cornerRadius(5)
        .padding(.horizontal, 20)
        .padding(.bottom, 10)

    }
}

struct HypedEventDetailsButtonViewRegular: View {
    var text: String
    var backgroundColor: Color
    var imageName: String

    var body: some View {
        HStack {
            Image(systemName: imageName)
            Text(text)
        }
        .font(.title)
        .padding(12)
        .background(backgroundColor)
        .foregroundColor(.white)
        .cornerRadius(5)
    }
}

struct HypeEventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HypeEventDetailView(hypeEvent: testHypeEvents2)
                .previewDevice("iPhone 11")
            HypeEventDetailView(hypeEvent: testHypeEvents1)
            HypedEventDetailsButtonView(text: "Testing", backgroundColor: .green, imageName: "clock").previewLayout(.sizeThatFits)
            HypedEventDetailsButtonViewRegular(text: "Compact", backgroundColor: .orange, imageName: "clock").previewLayout(.sizeThatFits)
        }
    }
}
