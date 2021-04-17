//
//  HypedEventLabel.swift
//  HypedList
//
//  Created by Natalia  Stele on 08/04/2021.
//

import SwiftUI

struct FormLabelView: View {

    var title: String
    var color: Color
    var imageName: String

    var body: some View {
        Label {
            Text(title)
        } icon: {
            Image(systemName: imageName)
                .padding(4)
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(7)
        }
    }
}

struct HypedEventLabel_Previews: PreviewProvider {
    static var previews: some View {
        FormLabelView(title: "Testing Preview 2", color: Color.green, imageName: "play.circle")
            .previewLayout(.sizeThatFits)
    }
}
