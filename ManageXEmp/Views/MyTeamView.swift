import SwiftUI

struct MyTeamView: View {
    var body: some View {
        NavigationStack {
            EmployeeTableView()
                .navigationTitle("My Team")
        }
    }
}

