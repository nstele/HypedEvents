//
//  MainView.swift
//  HypedListiOS
//
//  Created by Natalia  Stele on 15/04/2021.
//

import SwiftUI

struct MainView: View {

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        if (horizontalSizeClass == .compact) {
            HypedListTabView()
        } else {
            HypedListSidebarView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
