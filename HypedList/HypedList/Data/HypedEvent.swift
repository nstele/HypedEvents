//
//  HypedEvent.swift
//  HypedList
//
//  Created by Natalia  Stele on 07/04/2021.
//

import SwiftUI
import SwiftDate
import UIColor_Hex_Swift

class HypedEvent: ObservableObject, Identifiable, Codable {
    var id = UUID().uuidString
    @Published var date = Date()
    @Published var title = ""
    @Published var url = ""
    @Published var color = Color.purple
    @Published var imageData: Data?

    init() {

    }

    enum CodingKeys: String, CodingKey {
        case id
        case date
        case title
        case color
        case url
        case imageData
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: CodingKeys.id)
        try container.encode(date, forKey: CodingKeys.date)
        try container.encode(title, forKey: CodingKeys.title)
        try container.encode(UIColor(color).hexString(), forKey: CodingKeys.color)
        try container.encode(url, forKey: CodingKeys.url)
        try container.encode(imageData, forKey: CodingKeys.imageData)
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        date = try values.decode(Date.self, forKey: .date)
        title = try values.decode(String.self, forKey: .title)
        url = try values.decode(String.self, forKey: .url)
        imageData = try? values.decode(Data.self, forKey: .imageData)
        let colorHex = try values.decode(String.self, forKey: .color)
        color = Color(UIColor(colorHex))
    }

    func image() -> Image? {
        if let eventImage = imageData, let image = UIImage(data: eventImage) {
            return Image(uiImage: image)
        }
        return nil
    }

    func dateAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        if !date.compare(.isThisYear) {
           formatter.dateFormat = "MMM d yyyy"
        }
        return formatter.string(from: date)
    }

    func dateFromNow() -> String {
        return date.toRelative()
    }

    func validURL() ->  URL? {
      return URL(string: url)
    }

    #if !os(watchOS)
    var hasBeenAdded: Bool {
        let event =  DataController.shared.hypedEvents.first { (event) -> Bool in
            return event.id == self.id
        }
        return event != nil
    }
    #endif
}

var testHypeEvents1: HypedEvent {
    let event = HypedEvent()

//    if let image = UIImage(named: "wwdc"), let data = image.jpegData(compressionQuality: 0.9) {
//        event.imageData = data
//    }
    event.title = "WWDC 2021"
    event.color = .orange
    event.date = Date() + 4.days + 1.years
    event.url = "apple.com"
    return event
}

var testHypeEvents2: HypedEvent {
    let event = HypedEvent()

    if let image = UIImage(named: "wwdc2"), let data = image.jpegData(compressionQuality: 0.9) {
        event.imageData = data
    }
    event.title = "Family trip to Jackson, this is family and friends trip that you could enjoy"
    event.color = .pink
    event.date = Date()
    event.url = "www.mapright.com"
    return event
}
