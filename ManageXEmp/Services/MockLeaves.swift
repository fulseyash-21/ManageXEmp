import Foundation

struct MockLeave: Codable {
    let id: UUID
    let leaveDate: Date
    let leaveType: String
    let consecutiveLeave: Int
    let approved: Bool
    let declined: Bool
}

class MockLeaves {
    static func fetchLeaves() -> [MockLeave] {
        return [
            // Single-day leave
            MockLeave(
                id: UUID(),
                leaveDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 2))!,
                leaveType: "Sick Leave",
                consecutiveLeave: 1,
                approved: true,
                declined: false
            ),
            
            // 2-day consecutive leave (Casual Leave)
            MockLeave(
                id: UUID(),
                leaveDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 5))!,
                leaveType: "Casual Leave",
                consecutiveLeave: 1,
                approved: false,
                declined: false
            ),
            MockLeave(
                id: UUID(),
                leaveDate: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 6))!,
                leaveType: "Casual Leave",
                consecutiveLeave: 2,
                approved: false,
                declined: false
            ),
            
            // 3-day consecutive leave (Unpaid Leave)
            MockLeave(
                id: UUID(),
                leaveDate: Calendar.current.date(from: DateComponents(year: 2025, month: 8, day: 10))!,
                leaveType: "Unpaid Leave",
                consecutiveLeave: 1,
                approved: true,
                declined: false
            ),
            MockLeave(
                id: UUID(),
                leaveDate: Calendar.current.date(from: DateComponents(year: 2025, month: 8, day: 11))!,
                leaveType: "Unpaid Leave",
                consecutiveLeave: 2,
                approved: true,
                declined: false
            ),
            MockLeave(
                id: UUID(),
                leaveDate: Calendar.current.date(from: DateComponents(year: 2025, month: 8, day: 12))!,
                leaveType: "Unpaid Leave",
                consecutiveLeave: 3,
                approved: true,
                declined: false
            ),
            
            // 2-day consecutive leave (Sick Leave)
            MockLeave(
                id: UUID(),
                leaveDate: Calendar.current.date(from: DateComponents(year: 2025, month: 10, day: 18))!,
                leaveType: "Sick Leave",
                consecutiveLeave: 1,
                approved: true,
                declined: false
            ),
            MockLeave(
                id: UUID(),
                leaveDate: Calendar.current.date(from: DateComponents(year: 2025, month: 10, day: 19))!,
                leaveType: "Sick Leave",
                consecutiveLeave: 2,
                approved: true,
                declined: false
            ),
            
            // Single-day leave
            MockLeave(
                id: UUID(),
                leaveDate: Calendar.current.date(from: DateComponents(year: 2025, month: 11, day: 25))!,
                leaveType: "Casual Leave",
                consecutiveLeave: 1,
                approved: false,
                declined: true
            ),
            
            // Single-day leave
            MockLeave(
                id: UUID(),
                leaveDate: Calendar.current.date(from: DateComponents(year: 2025, month: 11, day: 27))!,
                leaveType: "Unpaid Leave",
                consecutiveLeave: 1,
                approved: true,
                declined: false
            )
        ]
    }
}
