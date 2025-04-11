import SwiftUI

class EggFarmViewModel: ObservableObject {
    let contact = EggFarmModel()
    @Published var isAddTapped = false
    @Published var isAddReminderTapped = false
    @Published var isAddGroupTapped = false
    @Published var isAddCollectTapped = false
    @Published var isGroup = false
    @Published var group = ChikenGroupModel(date: Date(), name: "", eggMade: [:], icon: "")
    @Published var model = ReminderModel(name: "",
                                         date: Date(),
                                         time: Date(),
                                         repeatTime: .Daily,
                                         category: .fifth)
}
