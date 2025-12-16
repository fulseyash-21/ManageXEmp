import Foundation
import CoreData

final class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    private let persistentContainer: NSPersistentContainer
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    /// Private initializer for the singleton instance (on-disk).
    private init() {
        persistentContainer = NSPersistentContainer(name: "ManageXEmp")
        
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    /// Creates an in-memory Core Data stack.
    internal init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "ManageXEmp")
        
        if inMemory {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            description.shouldAddStoreAsynchronously = false
            persistentContainer.persistentStoreDescriptions = [description]
        }
        
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    /// Saves changes in the main context.
    func saveContext() {
        let context = mainContext
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            print("Error saving context: \(nsError), \(nsError.userInfo)")
        }
    }
}
