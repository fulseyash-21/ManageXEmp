import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Group {
            MainTabView()
            .transition(.opacity)        }
    }
}

struct MainTabView: View {
    init() {
        // Configure tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black
        appearance.selectionIndicatorTintColor = UIColor.yellow
        
        // Normal state
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray
        ]
        
        // Selected state
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            CalenderHomeView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
            
            MyTeamView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Team")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
                }
        }
        .accentColor(.red)
        .preferredColorScheme(.dark)
    }
}
