import SwiftUI

struct ChikenGroupModel: Identifiable, Codable {
    var id = UUID().uuidString
    var date: Date
    var name: String
    var eggMade: [Date: Int]
    var icon: String
}
struct EggAddGroupModel {
 
}


