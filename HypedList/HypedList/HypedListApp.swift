//
//  HypedListApp.swift
//  HypedList
//
//  Created by Natalia  Stele on 07/04/2021.
//

import SwiftUI

@main
struct HypedListApp: App {
    var body: some Scene {
        WindowGroup {
           MainView()
            .onAppear(perform: {
                DataController.shared.getDiscoverEvents()
                DataController.shared.loadData()
            })
        }
    }
}
