import SwiftUI

class EggGroupViewModel: ObservableObject {
    let contact = EggGroupModel()

    func calculateTotalEggs(group: ChikenGroupModel) -> Int {
        return group.eggMade.values.reduce(0, +)
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}
