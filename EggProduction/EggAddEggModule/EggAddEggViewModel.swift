import SwiftUI

class EggAddEggViewModel: ObservableObject {
    let contact = EggAddEggModel()
    @Published var numberOfEgg = ""
    @Published var comment = ""
    @Published var isAdd = false
    
    func validateInput() -> Bool {
          guard !numberOfEgg.isEmpty else {
              return false
          }
          
          guard let _ = Int(numberOfEgg) else {
              return false
          }
          
          return true
      }
}
