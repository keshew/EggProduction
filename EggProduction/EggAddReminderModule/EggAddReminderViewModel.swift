import SwiftUI

class EggAddReminderViewModel: ObservableObject {
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
    
    init(reminder: ReminderModel? = nil) {
        if let reminder = reminder {
            isNever = false
            first = false
            self.title = reminder.name
            self.desc = ""
            self.date = reminder.date
            self.time = reminder.time
            
            switch reminder.repeatTime {
            case .Never:
                self.isNever = true
            case .Daily:
                self.isDaily = true
            case .Weekly:
                self.isWeekly = true
            case .Mounthly:
                self.isMountly = true
            case .Yearly:
                self.isYearly = true
            }
            
            switch reminder.category {
            case .first:
                self.first = true
            case .second:
                self.second = true
            case .third:
                self.third = true
            case .fourth:
                self.fourth = true
            case .fifth:
                self.fifth = true
            }
        }
    }
    
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

