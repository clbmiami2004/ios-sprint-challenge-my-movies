//
//  CoreDataStack.swift
//  MyMovies
//
//  Created by Lambda_School_Loaner_201 on 12/14/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyMovies")
        
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistence stores: \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func save(context: NSManagedObjectContext) throws {
        var error: Error?
        
        context.performAndWait {
            do {
                try context.save()
            }catch let saveError {
                error = saveError
            }
        }
        
        if let error = error { throw error }
    }
}
