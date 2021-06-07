//
//  CoreDataStack.swift
//  sephora-test
//
//  Created by Lau on 07/06/2021.
//

import CoreData

enum CoreDataStackType {
    case prod
    case test
}

final class CoreDataStack {
    
    // MARK: - Properties
    
    private let container: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    // MARK: - Initializer
    
    init(modelName: String, type: CoreDataStackType) {
        container = NSPersistentContainer(name: modelName)
        if type == .test {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
        }
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }
    
    
}
