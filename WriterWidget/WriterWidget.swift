//
//  WriterWidget.swift
//  WriterWidget
//
//  Created by Michal Jach on 06/11/2020.
//

import WidgetKit
import SwiftUI
import Intents
import CoreData

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [SimpleEntry] = [SimpleEntry(date: Date(), configuration: configuration)]
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct WriterWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 28, height: 28, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text("This is my example note which i need on home screen.")
                    .fontWeight(.medium)
                    .font(.system(size: 14))
                    .lineLimit(4)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("WidgetBackground"))
    }
}

@main
struct WriterWidget: Widget {
    let kind: String = "WriterWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WriterWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Bookmarked")
        .description("A Note you marked to show on the homescreen.")
    }
}

struct WriterWidget_Previews: PreviewProvider {
    static var previews: some View {
        WriterWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
