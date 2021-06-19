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

    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .short
        return df
    }

    var body: some View {
        NavigationView {
            VStack {


                List {
                    HStack {
                        TextField("Enter new task", text: $text, onCommit: add)
                        Button(action: add, label: {
                            Text("Save")
                        })
                    }
                    ForEach(tasks, id: \.id) { task in
                        HStack {
                            Text(task.body)
                            Spacer()
                            Text("\(dateFormatter.string(from: task.createdAt))")
                                .font(.footnote)
                                .foregroundColor(Color.gray)
                        }
                    }
                    .onDelete(perform: remove)
                }

            }
            .navigationTitle("Tasks")
        }
    }

    private func add() {
        if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let newTask = Task(context: viewContext)
            newTask.body = text
            saveContext()
        }
        text = ""
    }

    private func remove(at offsets: IndexSet) {
        for index in offsets {
            let task = tasks[index]
            viewContext.delete(task)
        }
        saveContext()
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

        ContentView().preferredColorScheme(.dark).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
