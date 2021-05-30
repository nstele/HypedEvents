//
//  PhotoToWatchDataController.swift
//  HypedListiOS
//
//  Created by Natalia  Stele on 18/04/2021.
//

import Foundation
import WatchConnectivity


class PhoneToWatchDataController: NSObject, WCSessionDelegate {


    static var shared = PhoneToWatchDataController()
    var session: WCSession?

    func setupSession() {
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
           print("Activated")
        default:
            print("Not able to talk to watch :(")

        }

    }

    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive")
    }

    func sessionDidDeactivate(_ session: WCSession) {
       print("sessionDidDeactivate")
    }

    func sendContext(context:[String:Any]) {
       try? session?.updateApplicationContext(context)
    }

    func convertHypedEventsToContext(hypedEvents: [HypedEvent]) -> [String:Any] {
        var imegeLessHypedEvents: [HypedEvent] = []
        for hypedEvent in hypedEvents {
            let hypedEventImageless = HypedEvent()
            hypedEventImageless.id = hypedEvent.id
            hypedEventImageless.title = hypedEvent.title
            hypedEventImageless.color = hypedEvent.color
            hypedEventImageless.url = hypedEvent.url
            hypedEventImageless.date = hypedEvent.date
            imegeLessHypedEvents.append(hypedEventImageless)
        }
        let enconder = JSONEncoder()
        if let enconded = try? enconder.encode(imegeLessHypedEvents) {
            return ["hypedEvents":enconded]
        }
        return [:]
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        DispatchQueue.global().async {
            if let userDefault = UserDefaults(suiteName: "group.com.stelenatalia.hypedlist") {
                if let data = userDefault.data(forKey: "hypedEvents") {
                    let decoder = JSONDecoder()
                    if let jsonEvents = try? decoder.decode([HypedEvent].self, from: data) {
                        DispatchQueue.main.async {
                            replyHandler(self.convertHypedEventsToContext(hypedEvents: jsonEvents))
                        }
                    }
                }
            }
        }
    }
}
