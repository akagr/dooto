//
//  Task.swift
//  Doot
//
//  Created by Akash Agrawal on 19/06/21.
//

import Foundation
import CoreData

class Task: NSManagedObject, Identifiable {
    @NSManaged var body: String?
    @NSManaged var createdAt: Date?
}

extension Task {
    static func getAllTasks() -> NSFetchRequest<Task> {
        let request = Task.fetchRequest() as! NSFetchRequest<Task>

        let sort = NSSortDescriptor(key: "createdAt", ascending: true)
        request.sortDescriptors = [sort]

        return request
    }
}
