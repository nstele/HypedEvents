//
//  WatchToPhoneDataController.swift
//  HypedListWatch Extension
//
//  Created by Natalia  Stele on 18/04/2021.
//


import Foundation
import WatchConnectivity


class WatchToPhoneDataController: NSObject, WCSessionDelegate, ObservableObject {

    static var shared = WatchToPhoneDataController()

    @Published var hypedEvents: [HypedEvent] = []

    var session = WCSession.default

    override init() {
        super.init()
        session.delegate = self
        session.activate()
        loadFromUserDefaults()
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("Activated")
            sendMessage()
        default:
            print("Not able to talk to watch :(")

        }
    }

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {

        decodeContext(context: applicationContext)
    }


    func decodeContext(context: [String:Any]) {
        if let hypedData = context["hypedEvents"] as? Data {
            let decoder = JSONDecoder()

            if let hypedEventsJson = try? decoder.decode([HypedEvent].self, from: hypedData) {
                DispatchQueue.main.async {
                    self.hypedEvents = hypedEventsJson
                    self.saveToUserDefauls()
                }
            }
        }
    }

    func saveToUserDefauls() {
        let userDefault = UserDefaults.standard
        let enconder = JSONEncoder()
        if let enconded = try? enconder.encode(self.hypedEvents) {
            userDefault.setValue(enconded, forKey: "hypedEvents")
            userDefault.synchronize()
        }
    }

    func loadFromUserDefaults() {
        DispatchQueue.global().async {
            if let data = UserDefaults.standard.data(forKey: "hypedEvents") {
                let decoder = JSONDecoder()
                if let jsonEvents = try? decoder.decode([HypedEvent].self, from: data) {
                    DispatchQueue.main.async {
                        self.hypedEvents = jsonEvents
                    }
                }
            }
        }
    }

    func sendMessage() {
        session.sendMessage(["I want" : "data"]) { (context) in
            self.decodeContext(context: context)
        } errorHandler: { (error) in
            print(error)
        }
    }
}

