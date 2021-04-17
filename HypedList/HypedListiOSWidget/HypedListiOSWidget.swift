//
//  HypedListiOSWidget.swift
//  HypedListiOSWidget
//
//  Created by Natalia  Stele on 13/04/2021.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> HypeEventEntry {

        let placeholderHypedEvent = HypedEvent()
        placeholderHypedEvent.color = .green
        placeholderHypedEvent.title = "Loading..."
        return HypeEventEntry(date: Date(), hypedEvent: testHypeEvents2)
    }

    func getSnapshot(in context: Context, completion: @escaping (HypeEventEntry) -> ()) {
        let upcoming = DataController.shared.getUpcomingForWidget()
        var entry = HypeEventEntry(date: Date(), hypedEvent: testHypeEvents2)

        if upcoming.count > 0 {
           entry = HypeEventEntry(date: Date(), hypedEvent: upcoming.randomElement())
        }
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [HypeEventEntry] = []
        let upcoming = DataController.shared.getUpcomingForWidget()

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< upcoming.count {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!
            let entry = HypeEventEntry(date: entryDate, hypedEvent: upcoming[hourOffset])
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct HypeEventEntry: TimelineEntry {
    let date: Date
    let hypedEvent: HypedEvent?
}

struct HypedListiOSWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {

        if let event = entry.hypedEvent {
            ZStack() {
                if event.image() == nil {
                    event.color
                }

                Color.black.opacity(0.2)

                Text(event.title)
                    .padding()
                    .foregroundColor(.white)
                    .font(fontSize())
                    .multilineTextAlignment(.center)

                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        Text(event.dateFromNow())
                            .padding(15)
                            .foregroundColor(.white)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(event.image()?
                            .resizable()
                            .scaledToFill())
        } else {
            Text("No events to display yet! You need to add somenthing")
                .padding()
        }


    }


    func fontSize() -> Font {
        switch widgetFamily {
        case .systemSmall:
            return .body
        case .systemMedium:
            return .title
        case .systemLarge:
            return .largeTitle
        default:
            return .body
        }
    }

    @main
    struct HypedListiOSWidget: Widget {
        let kind: String = "HypedListiOSWidget"

        var body: some WidgetConfiguration {
            StaticConfiguration(kind: kind, provider: Provider()) { entry in
                HypedListiOSWidgetEntryView(entry: entry)
            }
            .configurationDisplayName("Hyped Event Widget")
            .description("See you upcoming events!")
        }
    }

    struct HypedListiOSWidget_Previews: PreviewProvider {

        static var previews: some View {

            Group {
                // No image
                HypedListiOSWidgetEntryView(entry: HypeEventEntry(date: Date(), hypedEvent: testHypeEvents1))
                    .previewContext(WidgetPreviewContext(family: .systemSmall))

                HypedListiOSWidgetEntryView(entry: HypeEventEntry(date: Date(), hypedEvent: testHypeEvents1))
                    .previewContext(WidgetPreviewContext(family: .systemMedium))

                HypedListiOSWidgetEntryView(entry: HypeEventEntry(date: Date(), hypedEvent: testHypeEvents1))
                    .previewContext(WidgetPreviewContext(family: .systemLarge))

                //Full information
                HypedListiOSWidgetEntryView(entry: HypeEventEntry(date: Date(), hypedEvent: testHypeEvents2))
                    .previewContext(WidgetPreviewContext(family: .systemSmall))

                HypedListiOSWidgetEntryView(entry: HypeEventEntry(date: Date(), hypedEvent: testHypeEvents2))
                    .previewContext(WidgetPreviewContext(family: .systemMedium))

                HypedListiOSWidgetEntryView(entry: HypeEventEntry(date: Date(), hypedEvent: testHypeEvents2))
                    .previewContext(WidgetPreviewContext(family: .systemLarge))

                // No event
                HypedListiOSWidgetEntryView(entry: HypeEventEntry(date: Date(), hypedEvent: nil))
                    .previewContext(WidgetPreviewContext(family: .systemSmall))

                HypedListiOSWidgetEntryView(entry: HypeEventEntry(date: Date(), hypedEvent: nil))
                    .previewContext(WidgetPreviewContext(family: .systemMedium))

                HypedListiOSWidgetEntryView(entry: HypeEventEntry(date: Date(), hypedEvent: nil))
                    .previewContext(WidgetPreviewContext(family: .systemLarge))
            }

        }
    }
}
