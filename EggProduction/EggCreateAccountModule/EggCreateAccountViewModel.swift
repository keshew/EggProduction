import SwiftUI

class EggCreateAccountViewModel: ObservableObject {
    let contact = EggCreateAccountModel()
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    @Published var confirmPassword = ""
    @Published var isImagePick = false
    @Published var selectedImage: UIImage?
    @Published var isGuest = false
    @Published var isLog = false
    @Published var isOnb = false
}
