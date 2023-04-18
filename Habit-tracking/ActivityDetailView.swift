//
//  DetailView.swift
//  Habit-tracking
//
//  Created by csuftitan on 4/15/23.
//

import SwiftUI

struct ActivityDetailView: View {
    
    @ObservedObject var activities: Activities
    
    @State private var completedTimes = 0
    var activity: Activity
    
    var body: some View {
        Form {
            Section(header: Text("Description for activity")) {
                Text("\(self.activity.description)")
            }
            
            Section(header: Text("Change Completed Times")) {
                Stepper(value: $completedTimes, in: 0...Int.max, step: 1) {
                    Text("Completed times: \(self.completedTimes)")
                }
            }
        }
        .navigationBarTitle(Text("\(self.activity.name)"))
        .navigationBarItems(trailing: Button(action: {
            self.saveActivity()
        }, label: {
            Text("Save")
        }))
            .onAppear {
                self.completedTimes = self.activity.completedTimes
        }
    }
    
    func saveActivity() {
        if let indexItem = self.activities.items.firstIndex(where: { (item) -> Bool in
            item == self.activity
        }) {
            let tempActivity = Activity(name: self.activity.name, description: self.activity.description, completedTimes: self.completedTimes)
            self.activities.items.remove(at: indexItem)
            self.activities.items.insert(tempActivity, at: indexItem)
            
            self.activities.saveActivities()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activities: Activities(), activity: Activity(name: "Name", description: "Description", completedTimes: 0))
    }
}
