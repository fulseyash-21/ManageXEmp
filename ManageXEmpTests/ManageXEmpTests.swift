
import XCTest
import CoreData
@testable import ManageXEmp

final class ManageXEmpTests: XCTestCase {

    var mockStack: CoreDataStack!
    var teamStore: CoreDataTeamStore!
    var leaveStore: CoreDataLeaveStore!
    var context: NSManagedObjectContext!

    // This is called before each test
    override func setUpWithError() throws {
        // 1. Create a new in-memory stack for each test
        mockStack = CoreDataStack()
        context = mockStack.mainContext
        
        // 2. Initialize the stores with the in-memory stack
        teamStore = CoreDataTeamStore(coreDataStack: mockStack)
        leaveStore = CoreDataLeaveStore(coreDataStack: mockStack)
    }

    // This is called after each test
    override func tearDownWithError() throws {
        // 3. Destroy the stack. This clears the in-memory database completely.
        mockStack = nil
        context = nil
        teamStore = nil
        leaveStore = nil
    }

    // MARK: - CoreDataTeamStore Tests

    func testCacheMockEmployees_SavesData() throws {
        
        let mockData = MockTeamService.fetchTeam()

        let employees = teamStore.fetchEmployees()
        
        for mock in mockData {
            XCTAssertTrue(employees.contains { $0.name == mock.name},
                         "Employee \(mock.name) should not exist")
        }
    }

    func testCacheMockEmployees_PreventsDuplicates() throws {
        // Arrange
        let mockData = MockTeamService.fetchTeam()
        
        // Act
        teamStore.cacheMockEmployees(mockData) // First time
        teamStore.cacheMockEmployees(mockData) // Second time
        
        // Assert
        let employees = teamStore.fetchEmployees()
        XCTAssertEqual(employees.count, mockData.count, "Duplicate employees (based on name) should not be saved.")
    }

    // MARK: - CoreDataLeaveStore Tests
    
    func testCacheMockLeaves_SavesData() throws {
        leaveStore.deleteAllLeaves()
        let mockData = MockLeaves.fetchLeaves()

        // Act
        leaveStore.cacheMockLeaves(mockData)

        // Assert
        let leaves = leaveStore.fetchLeaves()
        XCTAssertEqual(leaves.count, mockData.count)

        for mock in mockData {
            let saved = leaves.first {
                abs($0.leaveDate!.timeIntervalSince(mock.leaveDate)) < 1
            }

            XCTAssertNotNil(saved, "Leave with date \(mock.leaveDate) should exist")
        }
    }

    func testCacheMockLeaves_PreventsDuplicates() throws {

        let mockData = MockLeaves.fetchLeaves()


        leaveStore.cacheMockLeaves(mockData) // First time
        leaveStore.cacheMockLeaves(mockData) // Second time
        
        // Assert
        let leaves = leaveStore.fetchLeaves()
        XCTAssertEqual(leaves.count, mockData.count, "Duplicate leaves (based on date) should not be saved.")
    }
    
    func testDeleteAllLeaves_RemovesAllEntries() throws {
        // Arrange
        let mockData = MockLeaves.fetchLeaves()
        leaveStore.cacheMockLeaves(mockData)
        
        // Verify setup
        XCTAssertFalse(leaveStore.fetchLeaves().isEmpty, "Pre-condition: Leaves must exist before deletion.")
        
        // Act
        leaveStore.deleteAllLeaves()
        
        // Assert
        let leaves = leaveStore.fetchLeaves()
        XCTAssertTrue(leaves.isEmpty, "All leaves should be deleted.")
    }
}

