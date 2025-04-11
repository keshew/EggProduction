import SwiftUI

class EggProfileViewModel: ObservableObject {
    let contact = EggProfileModel()
    @Published var isImagePick = false
    @Published var selectedImage: UIImage?
    @Published var isOut = false
    @Published var isCreate = false

    @Published var isPushNotif: Bool {
        didSet {
            UserDefaults.standard.set(isPushNotif, forKey: "isPushNotif")
        }
    }
    
    @Published var isEmailNotif: Bool {
          didSet {
              UserDefaults.standard.set(isEmailNotif, forKey: "isEmailNotif")
          }
      }
    
    init() {
        isEmailNotif = UserDefaults.standard.bool(forKey: "isEmailNotif")
        isPushNotif = UserDefaults.standard.bool(forKey: "isPushNotif")
      }
    
    
    func getImageFromUserDefaults() -> UIImage? {
        return UserDefaultsManager().loadImage(forEmail: UserDefaultsManager().getEmail() ?? "")
    }
}
