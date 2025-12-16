import SwiftUI

struct EmployeeDetailView: View {
    @ObservedObject var employee: Employee
    
    var body: some View {
        List {
            // Section 1: Header
            Section {
                VStack(alignment: .leading, spacing: 10) {
                    Text(employee.name ?? "Employee Name")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(employee.role ?? "Employee Role")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical)
            }
            
            // Section 2: Employment Details
            Section(header: Text("Employment Details")) {
                DetailRow(title: "Department", value: employee.department ?? "--")
                DetailRow(title: "Position", value: employee.position ?? "--")
                DetailRow(title: "Start Date", value: (employee.startDate ?? Date()).formatted(date: .long, time: .omitted))
            }
            
            // Section 3: Leave Allowance
            Section(header: Text("Leave Allowance")) {
                DetailRow(title: "Total Leaves", value: "\(employee.totalLeaves)")
                DetailRow(title: "Leaves Taken", value: "\(employee.leavesTaken)")
                DetailRow(title: "Remaining", value: "\(employee.remainingLeaves)")
                if employee.totalLeaves > 0 {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Leave Usage")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        ProgressView(value: Float(employee.leavesTaken), total: Float(employee.totalLeaves)) {
                            Text("Leave Usage Progress")
                        }
                        .tint(leaveProgressColor) // Dynamic color
                        
                        Text("\(employee.remainingLeaves) days remaining")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(leaveProgressColor)
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Employee Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var leaveProgressColor: Color {
        guard employee.totalLeaves > 0 else { return .gray }
        
        let percentage = Float(employee.leavesTaken) / Float(employee.totalLeaves)
        
        if percentage > 0.8 {
            return .red
        } else if percentage > 0.5 {
            return .orange
        } else {
            return .green
        }
    }
}

private struct DetailRow: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Text(value)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.trailing)
        }
    }
}


