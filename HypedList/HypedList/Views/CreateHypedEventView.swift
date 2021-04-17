//
//  CreateHypedEventView.swift
//  HypedList
//
//  Created by Natalia  Stele on 07/04/2021.
//

import SwiftUI

struct CreateHypedEventView: View {
    
    @StateObject var event = HypedEvent()
    @State var showTime = false
    @State var showImagePicker = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section {
                    FormLabelView(title: "Title", color: .green, imageName: "keyboard")
                    TextField("Family Vacation", text: $event.title)
                        .autocapitalization(.words)
                }
                
                Section {
                    FormLabelView(title: "Date", color: .blue, imageName: "calendar")
                    DatePicker("Date", selection: $event.date, displayedComponents: showTime ? [.date, .hourAndMinute] : [.date])
                        .datePickerStyle(GraphicalDatePickerStyle())
                    Toggle(isOn: $showTime) {
                        FormLabelView(title: "Time", color: .blue, imageName: "clock.fill")
                    }
                }
                
                Section {
                    if event.image() == nil {
                        HStack {
                            FormLabelView(title: "Image", color: .purple, imageName: "camera")
                            Spacer()
                            Button(action: {
                                showImagePicker = true
                            }) {
                                Text("Pick Image")
                            }
                        }
                    } else {
                        HStack {
                            FormLabelView(title: "Image", color: .purple, imageName: "camera")
                            Spacer()
                            Button(action: {
                                event.imageData = nil
                            }) {
                                Text("Remove Image")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                        
                        Button(action: {
                            showImagePicker = true
                        }) {
                            if let eventImage = event.image() {
                                eventImage
                                    .resizable()
                                    .aspectRatio(contentMode : .fit)
                            }
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }.sheet(isPresented: $showImagePicker) {
                    ImagePicker(imageData: $event.imageData)
                }
                
                Section {
                    ColorPicker(selection: $event.color) {
                        FormLabelView(title: "Color", color: .yellow, imageName: "eyedropper")
                    }
                }
                
                Section {
                    FormLabelView(title: "Website", color: .orange, imageName: "link")
                    TextField("Website", text: $event.url)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                }
            }
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
            }), trailing: Button(action: {
                DataController.shared.saveHypeEvent(hypedEvent: event)
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Done")
            }))
            .navigationTitle("Create")
        }
    }
}

struct CreateHypedEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHypedEventView()
    }
}
