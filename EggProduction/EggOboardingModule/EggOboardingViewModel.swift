import SwiftUI

class EggOboardingViewModel: ObservableObject {
    let contact = EggOboardingModel()
    @Published var isLog = false
    @Published var isStart = false

}
