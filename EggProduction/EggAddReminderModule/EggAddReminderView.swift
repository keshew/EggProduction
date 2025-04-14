import SwiftUI

struct EggAddReminderView: View {
    @StateObject var eggAddReminderModel =  EggAddReminderViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var alertMessage = ""
    var isEditing: Bool
    var remindModel: ReminderModel
    
    init(isEditing: Bool, remindModel: ReminderModel) {
         self.isEditing = isEditing
         self.remindModel = remindModel
         _eggAddReminderModel = StateObject(wrappedValue: EggAddReminderViewModel(reminder: isEditing ? remindModel : nil))
     }
    
    var body: some View {
        ZStack {
            Color(.mainYellow)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .foregroundStyle(.white)
                                .font(.title.weight(.bold))
                                .padding(.leading)
                        }
                        
                        Text("Reminder")
                            .Madimi(size: 30)
                            .padding(.leading)
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 20) {
                        VStack(spacing: 6) {
                            HStack {
                                Text("Title")
                                    .Madimi(size: 16)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            CustomTextFiled2(text: $eggAddReminderModel.title,
                                             placeholder: isEditing ? remindModel.name : "Enter reminder title")
                        }
                        
                        VStack(spacing: 6) {
                            HStack {
                                Text("When?")
                                    .Madimi(size: 16)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            HStack(spacing: 20) {
                                DateTF(date: $eggAddReminderModel.date,
                                       text: isEditing ? eggAddReminderModel.formnatDate(reminderDate: remindModel.date) : "Date")
                                .padding(.leading, UIScreen.main.bounds.width > 700 ? 15 : 0)
                                
                                TimeTF(time: $eggAddReminderModel.time,
                                       date: $eggAddReminderModel.date,
                                       text: isEditing ? eggAddReminderModel.formatTime(reminderTime: remindModel.time) : "Time")
                                
                                if UIScreen.main.bounds.width > 700 {
                                    Spacer()
                                }
                            }
                        }
                        
                        VStack(spacing: 6) {
                            HStack {
                                Text("Repeat")
                                    .Madimi(size: 16)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            VStack(spacing: 6) {
                                HStack(spacing: 6) {
                                    Button(action: {
                                        eggAddReminderModel.isNever = true
                                        eggAddReminderModel.isDaily = false
                                        eggAddReminderModel.isWeekly = false
                                        eggAddReminderModel.isMountly = false
                                        eggAddReminderModel.isYearly = false
                                    }) {
                                        Rectangle()
                                            .fill(.secondYellow)
                                            .frame(width: 75, height: 48)
                                            .cornerRadius(10)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.white, lineWidth: eggAddReminderModel.isNever ? 1 : 0)
                                                
                                                Text("Never")
                                                    .Madimi(size: 18)
                                            }
                                    }
                                    
                                    Button(action: {
                                        eggAddReminderModel.isNever = false
                                        eggAddReminderModel.isDaily = true
                                        eggAddReminderModel.isWeekly = false
                                        eggAddReminderModel.isMountly = false
                                        eggAddReminderModel.isYearly = false
                                    }) {
                                        Rectangle()
                                            .fill(.secondYellow)
                                            .frame(width: 67, height: 48)
                                            .cornerRadius(10)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.white, lineWidth: eggAddReminderModel.isDaily ? 1 : 0)
                                                
                                                Text("Daily")
                                                    .Madimi(size: 18)
                                            }
                                    }
                                    
                                    Button(action: {
                                        eggAddReminderModel.isNever = false
                                        eggAddReminderModel.isDaily = false
                                        eggAddReminderModel.isWeekly = true
                                        eggAddReminderModel.isMountly = false
                                        eggAddReminderModel.isYearly = false
                                    }) {
                                        Rectangle()
                                            .fill(.secondYellow)
                                            .frame(width: 86, height: 48)
                                            .cornerRadius(10)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.white, lineWidth: eggAddReminderModel.isWeekly ? 1 : 0)
                                                
                                                Text("Weekly")
                                                    .Madimi(size: 18)
                                            }
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.leading)
                                
                                HStack(spacing: 6) {
                                    Button(action: {
                                        eggAddReminderModel.isNever = false
                                        eggAddReminderModel.isDaily = false
                                        eggAddReminderModel.isWeekly = false
                                        eggAddReminderModel.isMountly = true
                                        eggAddReminderModel.isYearly = false
                                    }) {
                                        Rectangle()
                                            .fill(.secondYellow)
                                            .frame(width: 96, height: 48)
                                            .cornerRadius(10)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.white, lineWidth: eggAddReminderModel.isMountly ? 1 : 0)
                                                
                                                Text("Mountly")
                                                    .Madimi(size: 18)
                                            }
                                    }
                                    
                                    Button(action: {
                                        eggAddReminderModel.isNever = false
                                        eggAddReminderModel.isDaily = false
                                        eggAddReminderModel.isWeekly = false
                                        eggAddReminderModel.isMountly = false
                                        eggAddReminderModel.isYearly = true
                                    }) {
                                        Rectangle()
                                            .fill(.secondYellow)
                                            .frame(width: 77, height: 48)
                                            .cornerRadius(10)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.white, lineWidth: eggAddReminderModel.isYearly ? 1 : 0)
                                                
                                                Text("Yearly")
                                                    .Madimi(size: 18)
                                            }
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.leading)
                            }
                        }
                        
                        VStack(spacing: 6) {
                            HStack {
                                Text("Category")
                                    .Madimi(size: 16)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            HStack(spacing: 27) {
                                Button(action: {
                                    eggAddReminderModel.first = true
                                    eggAddReminderModel.second = false
                                    eggAddReminderModel.third = false
                                    eggAddReminderModel.fourth = false
                                    eggAddReminderModel.fifth = false
                                }) {
                                    Rectangle()
                                        .fill(.secondYellow)
                                        .frame(width: 52, height: 48)
                                        .cornerRadius(10)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.white, lineWidth: eggAddReminderModel.first ? 1 : 0)
                                            
                                            Image(.chicken)
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                        }
                                }
                                .padding(.leading, UIScreen.main.bounds.width > 700 ? 15 : 0)
                                
                                Button(action: {
                                    eggAddReminderModel.first = false
                                    eggAddReminderModel.second = true
                                    eggAddReminderModel.third = false
                                    eggAddReminderModel.fourth = false
                                    eggAddReminderModel.fifth = false
                                }) {
                                    Rectangle()
                                        .fill(.secondYellow)
                                        .frame(width: 52, height: 48)
                                        .cornerRadius(10)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.white, lineWidth: eggAddReminderModel.second ? 1 : 0)
                                            
                                            Image(.medicine)
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                        }
                                }
                                
                                Button(action: {
                                    eggAddReminderModel.first = false
                                    eggAddReminderModel.second = false
                                    eggAddReminderModel.third = true
                                    eggAddReminderModel.fourth = false
                                    eggAddReminderModel.fifth = false
                                }) {
                                    Rectangle()
                                        .fill(.secondYellow)
                                        .frame(width: 52, height: 48)
                                        .cornerRadius(10)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.white, lineWidth: eggAddReminderModel.third ? 1 : 0)
                                            
                                            Image(.photo)
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                        }
                                }
                                
                                Button(action: {
                                    eggAddReminderModel.first = false
                                    eggAddReminderModel.second = false
                                    eggAddReminderModel.third = false
                                    eggAddReminderModel.fourth = true
                                    eggAddReminderModel.fifth = false
                                }) {
                                    Rectangle()
                                        .fill(.secondYellow)
                                        .frame(width: 52, height: 48)
                                        .cornerRadius(10)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.white, lineWidth: eggAddReminderModel.fourth ? 1 : 0)
                                            
                                            Image(.work)
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                        }
                                }
                                
                                Button(action: {
                                    eggAddReminderModel.first = false
                                    eggAddReminderModel.second = false
                                    eggAddReminderModel.third = false
                                    eggAddReminderModel.fourth = false
                                    eggAddReminderModel.fifth = true
                                }) {
                                    Rectangle()
                                        .fill(.secondYellow)
                                        .frame(width: 52, height: 48)
                                        .cornerRadius(10)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.white, lineWidth: eggAddReminderModel.fifth ? 1 : 0)
                                            
                                            Image(.mark)
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                        }
                                }
                                
                                if UIScreen.main.bounds.width > 700 {
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding(.top)
                    
                    Spacer(minLength: 190)
                    
                    Button(action: {
                        if eggAddReminderModel.title.isEmpty ||
                            eggAddReminderModel.date == Date(timeIntervalSince1970: 0) ||
                            eggAddReminderModel.time == Date(timeIntervalSince1970: 0) {
                            alertMessage = "Please fill in all fields"
                            showAlert = true
                            return
                        }
                        
                        let selectedRepeat: Repeat = {
                            if eggAddReminderModel.isNever {
                                return .Never
                            } else if eggAddReminderModel.isDaily {
                                return .Daily
                            } else if eggAddReminderModel.isWeekly {
                                return .Weekly
                            } else if eggAddReminderModel.isMountly {
                                return .Mounthly
                            } else {
                                return .Yearly
                            }
                        }()
                        
                        let selectedCategory: Category = {
                            if eggAddReminderModel.first {
                                return .first
                            } else if eggAddReminderModel.second {
                                return .second
                            } else if eggAddReminderModel.third {
                                return .third
                            } else if eggAddReminderModel.fourth {
                                return .fourth
                            } else {
                                return .fifth
                            }
                        }()
                        
                        let reminder = ReminderModel(
                            id: isEditing ? remindModel.id : UUID().uuidString,
                            name: eggAddReminderModel.title,
                            date: eggAddReminderModel.date,
                            time: eggAddReminderModel.time,
                            repeatTime: selectedRepeat,
                            category: selectedCategory
                        )
                        
                        NotificationManager.shared.scheduleNotification(reminder: reminder)
                        let userDefaultsManager = UserDefaultsManager()
                        
                        if isEditing {
                            userDefaultsManager.editReminder(reminder: reminder)
                        } else {
                            userDefaultsManager.appendReminderToSavedReminders(reminder)
                        }
                       
                        
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Rectangle()
                            .fill(.white)
                            .frame(height: 54)
                            .cornerRadius(20)
                            .padding(.horizontal)
                            .overlay {
                                Text("Ok")
                                    .Madimi(size: 18)
                            }
                    }
                }
                .padding(.top)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    let isEditing = false
    EggAddReminderView(isEditing: isEditing, remindModel: ReminderModel(name: "",
                                                                        date: Date(),
                                                                        time: Date(),
                                                                        repeatTime: Repeat.Daily, category: Category.fifth))
}
