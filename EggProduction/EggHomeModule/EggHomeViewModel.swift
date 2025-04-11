import SwiftUI

class EggHomeViewModel: ObservableObject {
    let contact = EggHomeModel()
    @Published var isAddTapped = false
    @Published var isAddReminderTapped = false
    @Published var isAddGroupTapped = false
    @Published var isAddCollectTapped = false
    @Published var isEditing = false
    @Published var model = ReminderModel(name: "",
                                         date: Date(),
                                         time: Date(),
                                         repeatTime: .Daily,
                                         category: .fifth)
    
    func calculateTotalEggs() -> Int {
        guard let groups = UserDefaultsManager().loadGroups() else {
            return 0
        }
        
        return groups.reduce(0) { total, group in
            total + group.eggMade.values.reduce(0, +)
        }
    }
}
