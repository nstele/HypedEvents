//
//  HypedListTVApp.swift
//  HypedListTV
//
//  Created by Natalia  Stele on 19/04/2021.
//

import SwiftUI

@main
struct HypedListTVApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: {
                    DataController.shared.getDiscoverEvents()
                    DataController.shared.loadData()
                })
        }
    }
}
