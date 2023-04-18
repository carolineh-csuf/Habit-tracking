//
//  AddActivity.swift
//  Habit-tracking
//
//  Created by csuftitan on 4/15/23.
//

import SwiftUI

struct AddActivityView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var activities: Activities
    
    @State private var activityName = ""
    @State private var description = ""
    @State private var times = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter name of habit")) {
                    TextField("Name", text: $activityName)
                }
                
                Section(header: Text("Enter description of habit")) {
                    TextField("Descriptions", text: $description)
                }
                
                Section(header: Text("Completed times")) {
                    Stepper(value: $times, in: 0...Int.max, step: 1) {
                        Text("\(times) times")
                    }
                }
            }
            .navigationBarTitle("Add new Activity")
            .navigationBarItems(trailing: Button(action: {
                let item = Activity(name: self.activityName, description: self.description, completedTimes: self.times)
                self.activities.items.append(item)
                self.activities.saveActivities()
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Save")
            }))
        }
    }
}

struct AddActivity_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}
