import SwiftUI

/// `DummyProfileView`Actionable settings in the ProfileView are only for display currently.
struct ProfileView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 20) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.gray.opacity(0.8))
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Yash Fulse")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Senior")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                            Text("Engineering Department")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical)
                }
                
                // Section 2: Contact Info
                Section(header: Text("Contact Information")) {
                    Label("yash.fulse@managex.com", systemImage: "envelope.fill")
                    Label("+91 9*******22", systemImage: "phone.fill")
                }
                
                // Section 3: App Settings
                Section(header: Text("Settings")) {
                    Label("Notifications", systemImage: "bell.fill")
                    Label("Appearance", systemImage: "paintbrush.fill")
                    Label("Privacy & Security", systemImage: "lock.fill")
                }
                
                // Section 4: Actions
                Section(header: Text("Actions")) {
                    Button(role: .destructive) {
                        // Will handle member login state
                    } label: {
                        Label("Sign Out", systemImage: "arrow.right.to.line.circle.fill")
                            .foregroundColor(.red)
                    }
                }
                
                // Developer section to add/manage mock data
                Section(header: Text("Developer")) {
                    Button("Add Sample Employees") {
                        let context = CoreDataTeamStore()
                        let sampleData = MockTeamService.fetchTeam()
                         context.deleteAllEmployees() // Remove comment if you want to clear old leaves first
                        context.cacheMockEmployees(sampleData)
                    }
                    
                    Button("Add Sample Leaves") {
                        let context = CoreDataLeaveStore()
                        let sampleData = MockLeaves.fetchLeaves()
                         context.deleteAllLeaves() // Remove comment if you want to clear old leaves first
                        context.cacheMockLeaves(sampleData)
                    }

                    Button("Clear All Leaves", role: .destructive) {
                        let context = CoreDataLeaveStore()
                        context.deleteAllLeaves()
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Profile")
        }
    }
}
