import SwiftUI

@main
struct ManageXEmpApp: App {
    let coreDataStack = CoreDataStack.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataStack.mainContext)
        }
    }
}
