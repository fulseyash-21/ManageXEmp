# ManageXEmp

**ManageXEmp** is an iOS application built using **SwiftUI** that focuses on employee and leave management.
It demonstrates real-world app architecture, local data persistence using **Core Data**, and integration of **UIKit components inside SwiftUI**.

---

## ✨ Features

### Employee Management

* View a list of team members with their roles and profile information
* Persist employee data locally using Core Data
* Dynamic UI updates driven by SwiftUI state management

### Leave Management

* Display your own leave records with status and dates
* Supports multiple leave types (e.g. approved, pending, consecutive)
* Data persistence across app launches

### Calendar Integration

* UIKit calendar view embedded inside SwiftUI
* Visual markers for leave dates
* Tap on a date to view leave details

### Modern iOS Architecture

* SwiftUI + UIKit interoperability
* Clean separation between data, business logic, and views
* Testable Core Data layer with unit tests

---

## 📸 Screenshots

<img width="301.5" height="655.5" alt="simulator_screenshot_76D738D2-EF8B-42F2-B909-A3B7779524B1" src="https://github.com/user-attachments/assets/f7bf0354-2d6a-4d6b-af2d-839c5c3fb26d" />



<img width="301.5" height="655.5" alt="simulator_screenshot_D1909A87-93A4-4CD9-9850-D24670136D10" src="https://github.com/user-attachments/assets/b8d5e506-eaa5-4290-83ba-42f44308f31b" />



<img width="301.5" height="655.5" alt="simulator_screenshot_E7D3DD2B-3D5F-40CF-905F-F3CE2BAC6BCC" src="https://github.com/user-attachments/assets/4f7915a1-586d-457c-b340-9e4cb49a8d34" />



<img width="301.5" height="655.5" alt="simulator_screenshot_06634C8F-878D-4F92-B79E-12822EBE42CF" src="https://github.com/user-attachments/assets/2335ad63-43d0-43c1-8601-a4db5c78f156" />



## 🧠 Highlights

* **SwiftUI first approach** with UIKit where needed
* **Core Data** used for structured local persistence
* **Unit-tested data layer** (employees and leaves)
* Avoids fragile test assumptions (order, timing, date precision)
* CI-friendly test design


<img width="614" height="196" alt="Screenshot 2025-12-16 at 4 23 23 PM" src="https://github.com/user-attachments/assets/a0812195-bd31-49df-8e08-b704631e327c" />

<img width="614" height="276" alt="Screenshot 2025-12-16 at 4 23 50 PM" src="https://github.com/user-attachments/assets/3f7a6911-38a5-4c7e-a89b-38d8d2011470" />

---

## 🛠 Tech Stack used

* **Language:** Swift
* **UI Framework:** SwiftUI, UIKit
* **Persistence:** Core Data
* **Architecture:** MVVM-style separation
* **Testing:** XCTest
* **IDE:** Xcode 15+

---

## ▶️ How to Run the Project

### Prerequisites

* macOS with **Xcode 15 or later**
* iOS Simulator (iOS 17+ recommended)

### Steps

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/ManageXEmp.git
   ```

2. Open the project:

   ```bash
   open ManageXEmp.xcodeproj
   ```

3. Select an iOS Simulator.

4. Press **Run (⌘R)**.

---

## 🧪 Running Tests

To run unit tests:

* In Xcode, press **⌘U**
* Or select **Product → Test**

Tests cover:

* Employee data caching and retrieval
* Leave data persistence and correctness
* Core Data isolation for reliable test execution

---

## 📂 Project Structure (High Level)

```
ManageXEmp
├── Views            # SwiftUI screens
├── ViewModels       # Business logic & state
├── CoreData         # Persistence layer
├── Services         # Mock & data services
├── Tests            # Unit tests (XCTest)
```

---

## 🚀 Future Improvements

* Network-backed API integration
* Authentication and user roles
* Cloud sync (CloudKit)
* Enhanced test coverage for UI flows

---
