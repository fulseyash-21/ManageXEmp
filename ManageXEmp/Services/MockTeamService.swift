import Foundation

struct MockEmployee: Codable {
    let id: UUID
    let name: String
    let startDate: Date
    let department: String
    let role: String
    let position: String
    let teamPos: String
    let totalLeaves: Int
    let leavesTaken: Int
    let remainingLeaves: Int
}

/// Provides static mock data which simulates a network fetch.
class MockTeamService {
    
    static func fetchTeam() -> [MockEmployee] {
        return [
            MockEmployee(
                id: UUID(),
                name: "Nathan Drake",
                startDate: Calendar.current.date(from: DateComponents(year: 2022, month: 3, day: 15))!,
                department: "Engineering",
                role: "iOS Developer",
                position: "Senior Software Engineer",
                teamPos: "1",
                totalLeaves: 24,
                leavesTaken: 10,
                remainingLeaves: 14
            ),
            MockEmployee(
                id: UUID(),
                name: "Elena Fisher",
                startDate: Calendar.current.date(from: DateComponents(year: 2023, month: 1, day: 10))!,
                department: "Design",
                role: "UI/UX Designer",
                position: "Product Designer",
                teamPos: "1.1",
                totalLeaves: 20,
                leavesTaken: 6,
                remainingLeaves: 14
            ),
            MockEmployee(
                id: UUID(),
                name: "Victor Sullivan",
                startDate: Calendar.current.date(from: DateComponents(year: 2021, month: 9, day: 1))!,
                department: "Operations",
                role: "Manager",
                position: "Operations Lead",
                teamPos: "1.2",
                totalLeaves: 30,
                leavesTaken: 18,
                remainingLeaves: 12
            ),
            MockEmployee(
                id: UUID(),
                name: "Chloe Frazer",
                startDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 12))!,
                department: "Marketing",
                role: "Marketing Specialist",
                position: "Brand Strategist",
                teamPos: "1.1.1",
                totalLeaves: 22,
                leavesTaken: 5,
                remainingLeaves: 17
            ),
            MockEmployee(
                id: UUID(),
                name: "Sam Drake",
                startDate: Calendar.current.date(from: DateComponents(year: 2020, month: 11, day: 20))!,
                department: "Sales",
                role: "Account Executive",
                position: "Sales Manager",
                teamPos: "1.1.2",
                totalLeaves: 25,
                leavesTaken: 9,
                remainingLeaves: 16
            ),
            MockEmployee(
                id: UUID(),
                name: "Cutter Hall",
                startDate: Calendar.current.date(from: DateComponents(year: 2024, month: 2, day: 5))!,
                department: "Human Resources",
                role: "HR Coordinator",
                position: "Talent Acquisition",
                teamPos: "1.1.3",
                totalLeaves: 26,
                leavesTaken: 7,
                remainingLeaves: 19
            ),
            MockEmployee(
                id: UUID(),
                name: "Tenzin Norbu",
                startDate: Calendar.current.date(from: DateComponents(year: 2021, month: 8, day: 25))!,
                department: "Engineering",
                role: "Backend Developer",
                position: "Software Engineer II",
                teamPos: "1.2.1",
                totalLeaves: 24,
                leavesTaken: 12,
                remainingLeaves: 12
            ),
            MockEmployee(
                id: UUID(),
                name: "Rika Raja",
                startDate: Calendar.current.date(from: DateComponents(year: 2022, month: 12, day: 1))!,
                department: "Finance",
                role: "Financial Analyst",
                position: "Senior Accountant",
                teamPos: "1.2.2",
                totalLeaves: 28,
                leavesTaken: 15,
                remainingLeaves: 13
            )
        ]
    }
}

