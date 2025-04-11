import SwiftUI

struct EggAlarmView: View {
    @StateObject var eggAlarmModel =  EggAlarmViewModel()
    @AppStorage("isEgg") private var isEgg = false
    @State private var minutes: TimeInterval = 0
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack {
                Rectangle()
                    .fill(.mainYellow)
                    .overlay {
                        VStack(spacing: 30) {
                            Image(.alarm)
                                .resizable()
                                .frame(width: 280, height: 291)
                            
                            VStack(spacing: 15) {
                                Button(action: {
                                    isEgg = false
                                }) {
                                    Rectangle()
                                        .fill(.white)
                                        .cornerRadius(12)
                                        .frame(height: 54)
                                        .overlay {
                                            Text("Ok! I got it")
                                                .Madimi(size: 18)
                                        }
                                        .padding(.horizontal)
                                }
                                HStack(spacing: 25) {
                                    Button(action: {
                                        minutes = 300
                                        scheduleNotification()
                                        isEgg = false
                                    }) {
                                        Rectangle()
                                            .fill(.secondYellow)
                                            .frame(width: 94, height: 54)
                                            .cornerRadius(20)
                                            .overlay {
                                                Text("5 min")
                                                    .Madimi(size: 18)
                                            }
                                    }
                                    
                                    Button(action: {
                                        minutes = 900
                                        scheduleNotification()
                                        isEgg = false
                                    }) {
                                        Rectangle()
                                            .fill(.secondYellow)
                                            .frame(width: 94, height: 54)
                                            .cornerRadius(20)
                                            .overlay {
                                                Text("15 min")
                                                    .Madimi(size: 18)
                                            }
                                    }
                                    
                                    Button(action: {
                                        minutes = 3600
                                        scheduleNotification()
                                        isEgg = false
                                    }) {
                                        Rectangle()
                                            .fill(.secondYellow)
                                            .frame(width: 94, height: 54)
                                            .cornerRadius(20)
                                            .overlay {
                                                Text("1 h")
                                                    .Madimi(size: 18)
                                            }
                                    }
                                }
                            }
                        }
                    }
                    .frame(height: 539)
                    .cornerRadius(20)
                    .padding(.horizontal)

            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Remind"
        content.body = "Time's up!"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: minutes, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}


#Preview {
    EggAlarmView()
}

