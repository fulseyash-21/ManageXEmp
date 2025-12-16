import Foundation
import CoreData

/// Manages saving and fetching `Leave` entities from Core Data.
class CoreDataLeaveStore {
    
    private let context: NSManagedObjectContext
    
    /// Initializes the store with the shared Core Data context.
    init(coreDataStack: CoreDataStack = .shared) {
        self.context = coreDataStack.mainContext
    }
    
    /// Fetches all `Leave` objects from Core Data.
    func fetchLeaves() -> [Leave] {
        let request: NSFetchRequest<Leave> = Leave.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching employeees: \(error)")
            return []
        }
    }
    

    func cacheMockLeaves(_ mockLeaves: [MockLeave]) {
        // Fetch and check existing leaves to prevent duplicates
        let existingLeaves = fetchLeaves()
        let existingNames = Set(existingLeaves.compactMap { $0.leaveDate })

        for mock in mockLeaves {
            // Only add if name isn't already in the store
            guard !existingNames.contains(mock.leaveDate) else {
                continue
            }
            
            let leave = Leave(context: context)
            leave.id = mock.id
            leave.leaveDate = mock.leaveDate
            leave.leaveType = mock.leaveType
            leave.consecutiveLeave = Int16(mock.consecutiveLeave)
            leave.approved = mock.approved
            leave.declined = mock.declined

        }
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving mock data to Core Data: \(error)")
            }
        }
    }
    
    
    func deleteAllLeaves() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Leave.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
        } catch {
            print("Error delete mock data to Core Data: \(error)")
        }
    }
}

