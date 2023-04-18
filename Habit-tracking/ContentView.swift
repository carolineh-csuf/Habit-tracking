//
//  ContentView.swift
//  Habit-tracking
//
//  Created by csuftitan on 4/15/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var activities = Activities()
    @State private var showingAddActivity = false
   
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items){ item in
                    NavigationLink(destination: ActivityDetailView(activities: self.activities, activity: item)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.description)
                            }
                            Spacer()
                            Text("\(item.completedTimes)")
                        }
                    }
                }
            }
        .navigationBarTitle(Text("Habit-tracking"))
            .navigationBarItems(trailing: Button(action: {
                self.showingAddActivity = true
            }, label: {
                Image(systemName: "plus")
            }))
                .sheet(isPresented: $showingAddActivity) {
                    AddActivityView(activities: self.activities)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
