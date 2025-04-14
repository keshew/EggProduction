import SwiftUI

enum Repeat: String, Codable {
    case Never
    case Daily
    case Weekly
    case Mounthly
    case Yearly
}

enum Category: String, Codable {
    case first
    case second
    case third
    case fourth
    case fifth
}

struct ReminderModel: Identifiable, Codable {
    var id = UUID().uuidString
    var name: String
    var date: Date
    var time: Date
    var repeatTime: Repeat
    var category: Category
}

struct EggAddReminderModel {
 
}

extension ReminderModel {
    func isEmpty() -> Bool {
        return name.isEmpty && date == Date(timeIntervalSince1970: 0) && time == Date(timeIntervalSince1970: 0)
    }
}
