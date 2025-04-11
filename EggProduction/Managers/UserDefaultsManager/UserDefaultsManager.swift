import SwiftUI

final class UserDefaultsManager {
    private let defaults = UserDefaults.standard
    
    func isFirstLaunch() -> Bool {
        let defaults = UserDefaults.standard
        let isFirstLaunch = defaults.bool(forKey: "isFirstLaunch")
        
        if !isFirstLaunch {
            defaults.set(true, forKey: "isFirstLaunch")
            return true
        }
        
        return false
    }
    
    func enterAsGuest() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "guest")
    }
    
    func isGuest() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "guest")
    }
    
    func quitQuest() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "guest")
    }
    
    func saveImage(image: UIImage, forEmail email: String) {
        let userDefaults = UserDefaults.standard
        var storedUsers: [String: [String: Any]] = [:]
        
        if let existingUsers = userDefaults.dictionary(forKey: "users") as? [String: [String: Any]] {
            storedUsers = existingUsers
        }
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "\(email).png"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        if let imageData = image.pngData() {
            do {
                try imageData.write(to: fileURL, options: .atomic)
                
                var userData: [String: Any] = storedUsers[email] ?? [:]
                userData["imagePath"] = fileName
                storedUsers[email] = userData
                
                userDefaults.set(storedUsers, forKey: "users")
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func loadImage(forEmail email: String) -> UIImage? {
        let userDefaults = UserDefaults.standard
        if let storedUsers = userDefaults.dictionary(forKey: "users") as? [String: [String: Any]],
           let userData = storedUsers[email],
           let imagePath = userData["imagePath"] as? String {
            
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent(imagePath)
            
            if let imageData = try? Data(contentsOf: fileURL) {
                return UIImage(data: imageData)
            }
        }
        return nil
    }
    
    func register(email: String, password: String, nickname: String, image: UIImage? = nil) -> Bool {
        let userDefaults = UserDefaults.standard
        var storedUsers: [String: [String: Any]] = [:]
        
        if let existingUsers = userDefaults.dictionary(forKey: "users") as? [String: [String: Any]] {
            storedUsers = existingUsers
        }
        
        if storedUsers[email] != nil {
            return false
        }
        
        var userData: [String: Any] = ["password": password, "nickname": nickname]
        
        if let image = image {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileName = "\(email).png"
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            
            if let imageData = image.pngData() {
                do {
                    try imageData.write(to: fileURL, options: .atomic)
                    userData["imagePath"] = fileName
                } catch {
                    print("Ошибка сохранения изображения: \(error)")
                    return false
                }
            }
        }
        
        storedUsers[email] = userData
        userDefaults.set(storedUsers, forKey: "users")
        return true
    }
    
    func updateProfileImage(email: String, image: UIImage) {
        let defaults = UserDefaults.standard
        if var storedUsers = defaults.dictionary(forKey: "users") as? [String: [String: Any]] {
            if var userData = storedUsers[email] {
                if let imageData = image.pngData() {
                    userData["image"] = imageData
                    storedUsers[email] = userData
                    defaults.set(storedUsers, forKey: "users")
                }
            }
        }
    }

    func checkLogin() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "isLoggedIn")
    }
    
    private func saveLoginStatus(_ isLoggedIn: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(isLoggedIn, forKey: "isLoggedIn")
    }
    
    func getNickname(for email: String) -> String? {
        let defaults = UserDefaults.standard
        if let storedUsers = defaults.dictionary(forKey: "users") as? [String: [String: Any]] {
            return storedUsers[email]?["nickname"] as? String
        }
        return nil
    }
    
    func getEmail() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "currentEmail")
    }
    
    func deleteAccount() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "users")
        defaults.removeObject(forKey: "GroupsKey")
        defaults.removeObject(forKey: "RemindersKey")
        saveLoginStatus(false)
    }
    
    func logout() {
        saveLoginStatus(false)
        defaults.removeObject(forKey: "GroupsKey")
        defaults.removeObject(forKey: "RemindersKey")
    }
    
    func saveCurrentEmail(_ email: String) {
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "currentEmail")
    }
    
    func login(email: String, password: String) -> Bool {
        let defaults = UserDefaults.standard
        if let storedUsers = defaults.dictionary(forKey: "users") as? [String: [String: Any]] {
            for (storedEmail, storedUser) in storedUsers {
                if email == storedEmail && password == storedUser["password"] as? String {
                    saveLoginStatus(true)
                    saveCurrentEmail(email)
                    return true
                }
            }
        }
        return false
    }
    
    func appendReminderToSavedReminders(_ reminder: ReminderModel) {
        guard var reminders = loadReminders() else {
            saveReminders([reminder])
            return
        }
        
        reminders.append(reminder)
        saveReminders(reminders)
    }
    
    func editReminder(reminder: ReminderModel) {
        guard var reminders = loadReminders() else {
            return
        }
        
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[index] = reminder
            saveReminders(reminders)
        } else {
            print("Reminder not found for editing.")
        }
    }
    
    func saveReminders(_ reminders: [ReminderModel]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(reminders)
            defaults.set(data, forKey: "RemindersKey")
        } catch {
            print("Error encoding reminders: \(error)")
        }
    }

    func loadReminders() -> [ReminderModel]? {
        guard let data = defaults.data(forKey: "RemindersKey") else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([ReminderModel].self, from: data)
        } catch {
            print("Error decoding reminders: \(error)")
            return nil
        }
    }

    func appendGroupToSavedGroups(_ group: ChikenGroupModel) {
        guard var groups = loadGroups() else {
            saveGroups([group])
            return
        }
        
        groups.append(group)
        saveGroups(groups)
    }

    func saveGroups(_ groups: [ChikenGroupModel]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(groups)
            defaults.set(data, forKey: "GroupsKey")
        } catch {
            print("Error encoding groups: \(error)")
        }
    }

    func loadGroups() -> [ChikenGroupModel]? {
        guard let data = defaults.data(forKey: "GroupsKey") else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([ChikenGroupModel].self, from: data)
        } catch {
            print("Error decoding groups: \(error)")
            return nil
        }
    }
    
    func addEggToGroup(withId groupId: String, date: Date, count: Int) {
        guard var groups = loadGroups() else {
            return
        }
        
        if let index = groups.firstIndex(where: { $0.id == groupId }) {
            if groups[index].eggMade[date] != nil {
                groups[index].eggMade[date]! += count
            } else {
                groups[index].eggMade[date] = count
            }
            
            saveGroups(groups)
        }
    }
}
