import SwiftUI

class EggLogViewModel: ObservableObject {
    let contact = EggLogModel()
    @Published var email = ""
    @Published var password = ""
    @Published var isGuest = false
    @Published var isTabBar = false
    @Published var isCreate = false
}
