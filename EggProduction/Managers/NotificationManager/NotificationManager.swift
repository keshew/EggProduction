import UserNotifications
import SwiftUI

class NotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()
    @AppStorage("isEgg") private var isEgg = false
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func requestPermission(completion: @escaping (Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { success, error in
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    func scheduleNotification(reminder: ReminderModel) {
        let content = UNMutableNotificationContent()
        content.title = "Remind"
        content.body = reminder.name
        content.sound = .default
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: reminder.date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: reminder.time)
        
        var fullComponents = DateComponents()
        fullComponents.year = dateComponents.year
        fullComponents.month = dateComponents.month
        fullComponents.day = dateComponents.day
        fullComponents.hour = timeComponents.hour
        fullComponents.minute = timeComponents.minute
        
        let targetDate = calendar.date(from: fullComponents)!
        let interval = targetDate.timeIntervalSince(Date())
        
        if interval > 0 {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
            let request = UNNotificationRequest(identifier: reminder.id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        isEgg = true
        completionHandler()
    }
    
    func cancelAllNotifications() {
         UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
     }
}

