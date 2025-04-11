import SwiftUI

class EggAddGroupViewModel: ObservableObject {
    let contact = EggAddGroupModel()
    @Published var name = ""
    @Published var desc = ""
    @Published var first = true
    @Published var second = false
    @Published var third = false
    @Published var fourth = false
    @Published var fifth = false
}
