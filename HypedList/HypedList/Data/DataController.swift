//
//  DataController.swift
//  HypedList
//
//  Created by Natalia  Stele on 10/04/2021.
//

import Foundation
import SwiftDate
import UIColor_Hex_Swift
import SwiftUI
#if !os(tvOS)
import WidgetKit
#endif

class DataController: ObservableObject {

    static var shared = DataController()
    @Published var hypedEvents: [HypedEvent] = []
    @Published var discoverHypeEvents: [HypedEvent] = []


    var upcomingEvents: [HypedEvent] {
        return hypedEvents.filter { $0.date > Date().dateAt(.startOfDay)}.sorted { $0.date < $1.date }
    }

    var pastEvents: [HypedEvent] {
        return hypedEvents.filter { $0.date < Date().dateAt(.startOfDay)}.sorted { $0.date > $1.date }
    }


    func saveData() {
        DispatchQueue.global().async {
            if let userDefault = UserDefaults(suiteName: "group.com.stelenatalia.hypedlist") {
                let enconder = JSONEncoder()
                if let enconded = try? enconder.encode(self.hypedEvents) {
                    userDefault.setValue(enconded, forKey: "hypedEvents")
                    userDefault.synchronize()
                    #if !os(tvOS)
                    WidgetCenter.shared.reloadAllTimelines()
                    #endif
                }
            }
            self.sendDataToWatch()
        }
    }

    func loadData() {
        DispatchQueue.global().async {
            if let userDefault = UserDefaults(suiteName: "group.com.stelenatalia.hypedlist") {
                if let data = userDefault.data(forKey: "hypedEvents") {
                    let decoder = JSONDecoder()
                    if let jsonEvents = try? decoder.decode([HypedEvent].self, from: data) {
                        DispatchQueue.main.async {
                            self.hypedEvents = jsonEvents
                            self.sendDataToWatch()

                        }
                    }
                }
            }
        }
    }

    func sendDataToWatch() {
        #if !os(tvOS)
        let phoneToWatch = PhoneToWatchDataController.shared
        let context = phoneToWatch.convertHypedEventsToContext(hypedEvents: self.upcomingEvents)
        phoneToWatch.sendContext(context: context)
        #endif
    }

    // We should limite here the amount of events shared 
    func getUpcomingForWidget() -> [HypedEvent]  {
        if let userDefault = UserDefaults(suiteName: "group.com.stelenatalia.hypedlist") {
            if let data = userDefault.data(forKey: "hypedEvents") {
                let decoder = JSONDecoder()
                if let jsonEvents = try? decoder.decode([HypedEvent].self, from: data) {
                    return jsonEvents
                }
            }
        }
        return []
    }

    func addFromDiscover(hypedEvent: HypedEvent) {
        if !hypedEvent.hasBeenAdded {
            hypedEvents.append(hypedEvent)
            hypedEvent.objectWillChange.send()
            saveData()
        }
    }

    func deleteHypeEvent(hypedEvent: HypedEvent) {
        guard let index = hypedEvents.firstIndex(where: { (event) -> Bool in
            return event.id == hypedEvent.id
        }) else {
            return
        }

        hypedEvents.remove(at: index)
        saveData()
    }

    func saveHypeEvent(hypedEvent: HypedEvent) {
        if let index = hypedEvents.firstIndex(where: { (event) -> Bool in
            return event.id == hypedEvent.id
        }) {
            hypedEvents[index] = hypedEvent
        } else {
            hypedEvents.append(hypedEvent)
        }
        saveData()

    }

    func getDiscoverEvents() {
        if let url = URL(string: "https://api.jsonbin.io/b/607304adee971419c4d65cc8/latest") {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let jsonData = data {
                    if let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String:String]] {
                        var hypeRemoteEvents: [HypedEvent] = []
                        for jsonEvent in json {
                            let hypedEvent = HypedEvent()
                            if let id = jsonEvent["id"] {
                                hypedEvent.id = id
                            }

                            if let dateString = jsonEvent["date"] {
                                SwiftDate.defaultRegion = Region.local
                                if let dateInRegion = dateString.toDate() {
                                    hypedEvent.date =  dateInRegion.date
                                }
                            }

                            if let title = jsonEvent["title"] {
                                hypedEvent.title = title
                            }

                            if let url = jsonEvent["url"] {
                                hypedEvent.url = url
                            }

                            if let colorHex = jsonEvent["color"] {
                                hypedEvent.color = Color(UIColor(colorHex))
                            }

                            if let imageURL = jsonEvent["imageURL"], let url = URL(string: imageURL),
                               let data = try? Data(contentsOf: url) {
                                hypedEvent.imageData = data
                            }

                            hypeRemoteEvents.append(hypedEvent)

                        }
                        DispatchQueue.main.async {
                            self.discoverHypeEvents = hypeRemoteEvents
                        }
                    }
                }
            }.resume()
        }
    }
}
