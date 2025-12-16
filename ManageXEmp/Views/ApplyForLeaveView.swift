import SwiftUI
import CoreData

struct ApplyForLeaveView: View {
    // Core Data & Dismiss Environment
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    // Form State
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var leaveType = "Sick Leave"

    // Form Validation
    @State private var errorMessage: String?
    @State private var isSaving = false

    let leaveTypes = ["Sick Leave", "Casual Leave", "Unpaid Leave", "Annual Leave"]

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Leave Details")) {
                    DatePicker("Start Date", selection: $startDate, in: Date()..., displayedComponents: .date)
                    DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: .date) // Ensure end date is after start date
                    Picker("Leave Type", selection: $leaveType) {
                        ForEach(leaveTypes, id: \.self) { type in
                            Text(type).tag(type)
                        }
                    }
                }

                if let errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                }

                Section {
                    Button(action: submitLeaveRequest) {
                        if isSaving {
                            HStack {
                                Text("Submitting...")
                                Spacer()
                                ProgressView()
                            }
                        } else {
                            Text("Submit Request")
                        }
                    }
                    .disabled(isSaving)
                }
            }
            .navigationTitle("New Leave Request")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func submitLeaveRequest() {
        isSaving = true
        errorMessage = nil
        
        // Validation
        guard endDate > startDate else {
            errorMessage = "End date must be on or after the start date."
            isSaving = false
            return
        }
        
        let calendar = Calendar.current
        var datesToSave: [Date] = []
        var currentDate = startDate
        
        // 1. Get all dates in the range and also skip weekends
        while currentDate <= endDate {
            let dayOfWeek = calendar.component(.weekday, from: currentDate)
            if dayOfWeek != 1 && dayOfWeek != 7 { // 1st day Sunday, 7th day Saturday
                 datesToSave.append(calendar.startOfDay(for: currentDate)) // Use startOfDay for comparison
            }
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }

        if datesToSave.isEmpty {
            errorMessage = "No weekdays selected. Please select a range that includes at least one weekday."
            isSaving = false
            return
        }

        // 2. Check for existing leaves on these dates
        let existingLeavesRequest: NSFetchRequest<Leave> = Leave.fetchRequest()
        existingLeavesRequest.propertiesToFetch = ["leaveDate"] // Only need the date
        
        var existingLeaveDates = Set<Date>()
        do {
            let existingLeaves = try viewContext.fetch(existingLeavesRequest)
            existingLeaveDates = Set(existingLeaves.compactMap {
                guard let date = $0.leaveDate else { return nil }
                return calendar.startOfDay(for: date) // Normalize to start of day
            })
        } catch {
            errorMessage = "Could not check for existing leaves. \(error.localizedDescription)"
            isSaving = false
            return
        }
        
        let datesToSaveSet = Set(datesToSave)
        let overlappingDates = datesToSaveSet.intersection(existingLeaveDates)
        
        // Check for existing leaves
        if !overlappingDates.isEmpty {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            let datesString = overlappingDates.map(formatter.string).joined(separator: ", ")
            errorMessage = "A leave request already exists for the following date(s): \(datesString)"
            isSaving = false
            return
        }
        
        // 3. Save the new leaves
        for (index, date) in datesToSave.enumerated() {
            let newLeave = Leave(context: viewContext)
            newLeave.id = UUID()
            newLeave.leaveDate = date
            newLeave.leaveType = leaveType
            newLeave.approved = false // Default to pending
            newLeave.declined = false // Default to pending
            newLeave.consecutiveLeave = Int16(index + 1)
        }
        
        // Save to Core Data
        do {
            try viewContext.save()
            isSaving = false
            dismiss() // Close the sheet on success
        } catch {
            let nsError = error as NSError
            errorMessage = "Failed to save leave request: \(nsError.localizedDescription)"
            isSaving = false
        }
    }
}


