import SwiftUI
import UIKit

struct CalendarViewWithHighlights: UIViewRepresentable {
    @Binding var selectedDate: Date?
    var highlightedDates: [Date] = []  

    func makeUIView(context: Context) -> UICalendarView {
        let calendarView = UICalendarView()
        calendarView.delegate = context.coordinator

        let selectionBehavior = UICalendarSelectionSingleDate(delegate: context.coordinator)
        calendarView.selectionBehavior = selectionBehavior

        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.tintColor = .systemBlue
        calendarView.wantsDateDecorations = true

        return calendarView
    }

    func updateUIView(_ uiView: UICalendarView, context: Context) {
         let dates = highlightedDates.map {
            Calendar.current.dateComponents([.year, .month, .day], from: $0)
        }
        uiView.reloadDecorations(forDateComponents: dates, animated: false)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
        var parent: CalendarViewWithHighlights
        let calendar = Calendar.current

        init(parent: CalendarViewWithHighlights) {
            self.parent = parent
            super.init()
        }

        // MARK: - Decorations
        func calendarView(_ calendarView: UICalendarView,
                          decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            guard let date = calendar.date(from: dateComponents) else {
                return nil
            }
            if parent.highlightedDates.contains(where: { calendar.isDate($0, inSameDayAs: date) }) {
                return .default(color: .systemPink, size: .medium)
            }
            return nil
        }

        // MARK: - Selection
        func dateSelection(_ selection: UICalendarSelectionSingleDate,
                           didSelectDate dateComponents: DateComponents?) {
            if let comps = dateComponents,
               let date = calendar.date(from: comps) {
                DispatchQueue.main.async {
                    self.parent.selectedDate = date
                }
            } else {
                DispatchQueue.main.async {
                    self.parent.selectedDate = nil
                }
            }
        }

        func dateSelection(_ selection: UICalendarSelectionSingleDate,
                           canSelectDate dateComponents: DateComponents?) -> Bool {
            true
        }
    }
}
