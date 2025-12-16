import SwiftUI
import CoreData

struct HomeView: View {
    @State private var showApplySheet = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Employee.name, ascending: true)],
        animation: .default
    )
    private var employees: FetchedResults<Employee>

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Leave.leaveDate, ascending: true)],
        animation: .default
    )
    private var leaves: FetchedResults<Leave>

    // Properties
    private var pendingLeaves: [Leave] {
        leaves.filter { !$0.approved && !$0.declined }
    }
    
    private var upcomingApprovedLeaves: [Leave] {
        leaves.filter {
            $0.approved &&
            $0.leaveDate ?? Date() >= Calendar.current.startOfDay(for: Date())
        }
    }

    var body: some View {
        NavigationStack {
            List {
                // Section 1: Stats
                Section(header: Text("Team Overview").font(.headline)) {
                    StatCard(title: "Total Team Members", value: "\(employees.count)", icon: "person.3.fill", color: .blue)
                    StatCard(title: "Pending Requests", value: "\(pendingLeaves.count)", icon: "questionmark.circle.fill", color: .orange)
                    StatCard(title: "Upcoming Approved Leave", value: "\(upcomingApprovedLeaves.count)", icon: "calendar.badge.clock", color: .green)
                }

                // Section 2: Pending Requests
                if !pendingLeaves.isEmpty {
                    Section(header: Text("Pending Leave Requests").font(.headline)) {
                        ForEach(pendingLeaves) { leave in
                            LeaveRow(leave: leave)
                        }
                    }
                } else {
                    Section {
                        Text("No pending leave requests.")
                            .foregroundStyle(.secondary)
                    }
                }
                
                // Section 3: Upcoming Approved Leave
                if !upcomingApprovedLeaves.isEmpty {
                    Section(header: Text("Upcoming Approved Leave").font(.headline)) {
                        ForEach(upcomingApprovedLeaves) { leave in
                            LeaveRow(leave: leave)
                        }
                    }
                } else {
                    Section {
                        Text("No upcoming approved leaves.")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Home Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showApplySheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                        Text("Apply")
                    }
                }
            }
            .sheet(isPresented: $showApplySheet) {
                ApplyForLeaveView()
            }
        }
    }
}

struct StatCard: View {
    var title: String
    var value: String
    var icon: String
    var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
                .frame(width: 50, height: 50)
                .background(color.opacity(0.2))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(value)
                    .font(.title)
                    .fontWeight(.bold)
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

struct LeaveRow: View {
    @ObservedObject var leave: Leave
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(leave.leaveType ?? "Unknown Leave")
                .font(.headline)
            
            Text(leave.leaveDate ?? Date(), style: .date)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            HStack {
                // Different colors for different status
                if leave.approved {
                    Text("Approved")
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(4)
                        .background(Color.green.opacity(0.2))
                        .foregroundColor(.green)
                        .cornerRadius(4)
                } else if leave.declined {
                    Text("Declined")
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(4)
                        .background(Color.red.opacity(0.2))
                        .foregroundColor(.red)
                        .cornerRadius(4)
                } else {
                    Text("Pending")
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(4)
                        .background(Color.orange.opacity(0.2))
                        .foregroundColor(.orange)
                        .cornerRadius(4)
                }
            }
        }
        .padding(.vertical, 4)
    }
}
