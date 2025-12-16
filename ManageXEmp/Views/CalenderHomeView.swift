import SwiftUI
import UIKit
import CoreData

struct CalenderHomeView: View {
    @State private var selected: Date? = nil
    @State private var refreshId = UUID()
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Leave.leaveDate, ascending: true)
        ],
        animation: .default
    )
    private var leaves: FetchedResults<Leave>
    
    var highlights: [Date] {
        leaves.compactMap { $0.leaveDate }
    }
    
    // Computed property to find leaves for the selected date
    var selectedLeaves: [Leave] {
        guard let selectedDate = selected else { return [] }
        return leaves.filter { leave in
            guard let leaveDate = leave.leaveDate else { return false }
            return Calendar.current.isDate(leaveDate, inSameDayAs: selectedDate)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                CalendarViewWithHighlights(
                    selectedDate: $selected,
                    highlightedDates: highlights
                )
                .frame(height: 450)
                .padding(.horizontal)
                .id(refreshId)
                
                // Updated details section
                List {
                    if let s = selected {
                        Section(header: Text("Details for \(s.formatted(date: .long, time: .omitted))")) {
                            if selectedLeaves.isEmpty {
                                Text("No leave recorded for this date.")
                                    .foregroundStyle(.secondary)
                            } else {
                                ForEach(selectedLeaves) { leave in
                                    CalendarLeaveRow(leave: leave)
                                }
                            }
                        }
                    } else {
                        Section(header: Text("Details")) {
                            Text("Select a date to see leave details.")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Leave Calendar")
        }
        .onChange(of: leaves.count) {
            // Refresh calendar if leaves change
            refreshId = UUID()
        }
    }
}

// Helper View for showing leave details in the calendar
struct CalendarLeaveRow: View {
    @ObservedObject var leave: Leave
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(leave.leaveType ?? "Unknown Leave Type")
                .font(.headline)
            
            HStack {
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
                
                Spacer()
                
                Text("Consecutive Day: \(leave.consecutiveLeave)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

