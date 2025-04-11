import SwiftUI

class EggAddReminderViewModel: ObservableObject {
    let contact = EggAddReminderModel()
    @Published var title = ""
    @Published var desc = ""
    @Published var date = Date(timeIntervalSince1970: 0)
    @Published var time = Date(timeIntervalSince1970: 0)
    @Published var isNever = true
    @Published var isDaily = false
    @Published var isWeekly = false
    @Published var isMountly = false
    @Published var isYearly = false
    
    @Published var first = true
    @Published var second = false
    @Published var third = false
    @Published var fourth = false
    @Published var fifth = false
    
    func formatTime(reminderTime: Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        return "\(timeFormatter.string(from: reminderTime))"
    }
    
    func formnatDate(reminderDate: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return "\(dateFormatter.string(from: reminderDate))"
    }
}
