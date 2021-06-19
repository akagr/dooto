//
//  Task.swift
//  Doot
//
//  Created by Akash Agrawal on 19/06/21.
//

import Foundation
import CoreData

class Task: NSManagedObject, Identifiable {
    @NSManaged var body: String
    @NSManaged var createdAt: Date
    @NSManaged var id: UUID
}

extension Task {
    static func getAllTasks() -> NSFetchRequest<Task> {
        let request = Task.fetchRequest() as! NSFetchRequest<Task>

        let sort = NSSortDescriptor(key: "createdAt", ascending: false)
        request.sortDescriptors = [sort]

        return request
    }

    override func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
        createdAt = Date()
    }
}
