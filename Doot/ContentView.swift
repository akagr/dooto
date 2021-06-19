//
//  ContentView.swift
//  Doot
//
//  Created by Akash Agrawal on 19/06/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: Task.getAllTasks()) private var tasks: FetchedResults<Task>

    @State var text: String = "";

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("New Task")) {
                    HStack {
                        TextField("Enter new task", text: $text)
                        Button(action: {
                            if !text.isEmpty {
                                let newTask = Task(context: viewContext)
                                newTask.body = text
                                newTask.createdAt = Date()
                                do {
                                    try viewContext.save()
                                } catch {
                                    print(error)
                                }
                            }
                        }, label: {
                            Text("Save")
                        })
                    }
                }

                Section {
                    ForEach(tasks) { task in
                        VStack(alignment: .leading) {
                            Text(task.body!)
                            Text("\(task.createdAt!)")
                        }
                    }
                }
            }
            .navigationTitle("Tasks")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

        ContentView().preferredColorScheme(.dark).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
