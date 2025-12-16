import Foundation
import CoreData

/// Manages saving and fetching `Employee` entities from Core Data.
/// In case if in future a network fetch fails this data will be extremely usefull
class CoreDataTeamStore {
    
    private let context: NSManagedObjectContext
    
    /// Initializes the store with the shared Core Data context.
    init(coreDataStack: CoreDataStack = .shared) {
        self.context = coreDataStack.mainContext
    }
    
    /// Fetches all `Employees` objects from Core Data.
    func fetchEmployees() -> [Employee] {
        let request: NSFetchRequest<Employee> = Employee.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching employeees: \(error)")
            return []
        }
    }
    

    func cacheMockEmployees(_ mockEmployees: [MockEmployee]) {
        // Fetch existing employees to prevent duplicates
        let existingEmployees = fetchEmployees()
        let existingNames = Set(existingEmployees.compactMap { $0.name })
        
        for mock in mockEmployees {
            // Only add if name isn't already in the store
            guard !existingNames.contains(mock.name) else {
                continue
            }
            
            let employee = Employee(context: context)
            employee.id = mock.id
            employee.name = mock.name 
            employee.startDate = mock.startDate
            employee.role = mock.role
            employee.department = mock.department
            employee.position = mock.position
            employee.teamPos = mock.teamPos
            employee.totalLeaves = Int16(mock.totalLeaves)
            employee.leavesTaken = Int16(mock.leavesTaken)
            employee.remainingLeaves = Int16(mock.remainingLeaves)
        }
        
        // Save the context after adding new employees
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving mock data to Core Data: \(error)")
            }
        }
    }

    func deleteAllEmployees() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Employee.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
        } catch {
            print("Error delete mock data to Core Data: \(error)")
        }
    }
}

