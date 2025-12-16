import SwiftUI
import CoreData

struct EmployeeTableView: View {
    // Fetch all employees from Core Data
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Employee.name, ascending: true)
        ],
        animation: .default
    )
    private var employees: FetchedResults<Employee>
    
    var body: some View {
        VStack(alignment: .leading) {
            if employees.isEmpty {
                ContentUnavailableView(
                    "No Employees Found",
                    systemImage: "person.crop.circle.badge.exclamationmark",
                    description: Text("You can add sample employees from the 'Profile' tab.")
                )
            } else {
                List(employees) { emp in
                    NavigationLink(destination: EmployeeDetailView(employee: emp)) {
                        // Use a custom row view for a better look
                        EmployeeRowView(employee: emp)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}


private struct EmployeeRowView: View {
    @ObservedObject var employee: Employee

    var body: some View {
        HStack(spacing: 15) {
            
            VStack(alignment: .leading, spacing: 4) {
                Text(employee.name ?? "No Name")
                    .font(.headline)
                    .fontWeight(.semibold)
                Text(employee.role ?? "No Role")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

