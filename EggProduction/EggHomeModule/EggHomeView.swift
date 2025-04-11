import SwiftUI
import Charts

struct MonthlyData: Identifiable {
    let id = UUID()
    let month: String
    var value: Int
}

struct EggHomeView: View {
    @StateObject var eggHomeModel =  EggHomeViewModel()
    let maxColumnHeight: CGFloat = 100
    
    let columns = [GridItem(.flexible(), spacing: UIScreen.main.bounds.width > 900 ? 90 : UIScreen.main.bounds.width > 700 ? 40 : -10),
                   GridItem(.flexible(), spacing: UIScreen.main.bounds.width > 900 ? 90 : UIScreen.main.bounds.width > 700 ? 40 : -10)]
    
    @State var monthlyData: [MonthlyData] = [
        MonthlyData(month: "1", value: 0),
        MonthlyData(month: "2", value: 0),
        MonthlyData(month: "3", value: 0),
        MonthlyData(month: "4", value: 0),
        MonthlyData(month: "5", value: 0),
        MonthlyData(month: "6", value: 0),
        MonthlyData(month: "7", value: 0),
        MonthlyData(month: "8", value: 0),
        MonthlyData(month: "9", value: 0),
        MonthlyData(month: "10", value: 0),
        MonthlyData(month: "11", value: 0),
        MonthlyData(month: "12", value: 0)
    ]
    
    func loadMonthlyData() {
        guard let groups = UserDefaultsManager().loadGroups() else {
            return
        }
        
        var monthlyCounts: [Double] = Array(repeating: 0.0, count: 12)
        
        for group in groups {
            for (date, count) in group.eggMade {
                let calendar = Calendar.current
                let month = calendar.component(.month, from: date)
                monthlyCounts[month - 1] += Double(count) * 0.1
                
                if monthlyCounts.reduce(0, +) > 1000 {
                    return
                }
            }
        }
        
        let maxCount = min(monthlyCounts.max() ?? 0.0, 1000.0)
        
        guard maxCount > 0 else {
            return
        }
        
        for (index, count) in monthlyCounts.enumerated() {
            let normalizedValue = (count / maxCount) * maxColumnHeight
            if normalizedValue.isFinite {
                monthlyData[index].value = Int(normalizedValue)
            } else {
                monthlyData[index].value = 0
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color(.mainYellow)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Text("Egg Production")
                            .Madimi(size: 30)
                            .padding(.leading)
                        
                        Spacer()
                    }
                    
                    Image(.homeChicken)
                        .resizable()
                        .frame(height: 220)
                        .cornerRadius(20)
                        .padding(.horizontal)
                        .overlay {
                            VStack {
                                Spacer()
                                
                                HStack {
                                    Rectangle()
                                        .fill(Color(red: 236/255,
                                                    green: 192/255,
                                                    blue: 22/255))
                                        .frame(width: 190, height: 64)
                                        .cornerRadius(12)
                                        .overlay {
                                            HStack {
                                                Image(.egg)
                                                    .resizable()
                                                    .frame(width: 40, height: 40)
                                                    .padding(.leading, 10)
                                                
                                                Spacer()
                                                
                                                Text("\(eggHomeModel.calculateTotalEggs())")
                                                    .Madimi(size: 36)
                                                    .minimumScaleFactor(0.8)
                                                    .padding(.trailing, 10)
                                                
                                                Spacer()
                                            }
                                        }
                                        .padding(.leading, 35)
                                        .padding(.bottom)
                                    
                                    Spacer()
                                }
                            }
                        }
                    
                    LazyVGrid(columns: columns, spacing: 15) {
                        if let reminders = UserDefaultsManager().loadReminders() {
                            ForEach(reminders) { reminder in
                                if reminder.repeatTime == .Never {
                                    NonRepeatView(reminder: reminder)
                                        .onTapGesture {
                                            eggHomeModel.isEditing = true
                                            eggHomeModel.model = reminder
                                        }
                                } else {
                                    RepeatView(reminder: reminder)
                                        .onTapGesture {
                                            eggHomeModel.isEditing = true
                                            eggHomeModel.model = reminder
                                        }
                                }
                            }
                            .padding(.top)
                        }
                    }
                    
                    
                    Rectangle()
                        .fill(.white)
                        .overlay {
                            VStack(spacing: 6) {
                                HStack {
                                    Text("Overal Year Statistics")
                                        .Madimi(size: 18)
                                        .padding(.leading)
                                    Spacer()
                                }
                                
                                HStack(spacing: 10.5) {
                                    ForEach(Array(monthlyData.enumerated()), id: \.element.id) { index, data in
                                        VStack(spacing: 6) {
                                            ZStack(alignment: .bottom) {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color(red: 244/255, green: 244/255, blue: 244/255))
                                                    .frame(width: 18, height: maxColumnHeight)
                                                
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color(red: 189/255, green: 136/255, blue: 16/255))
                                                    .frame(width: 18, height: CGFloat(data.value))
                                            }
                                            
                                            Text("\(index + 1)")
                                                .Madimi(size: 12)
                                        }
                                    }
                                }
                            }
                        }
                        .frame(height: 174)
                        .cornerRadius(24)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    
                    Color(.clear)
                        .frame(height: 70)
                }
                .padding(.top)
            }
            .scrollDisabled(eggHomeModel.isAddTapped ? true : false)
            
            if eggHomeModel.isAddTapped {
                Color.mainBrown
                    .ignoresSafeArea()
                    .opacity(0.7)
                    .onTapGesture {
                        eggHomeModel.isAddTapped.toggle()
                    }
            }
            
            VStack(spacing: 10) {
                VStack(alignment: .trailing, spacing: 10) {
                    if eggHomeModel.isAddTapped {
                        HStack(spacing: 15) {
                            Rectangle()
                                .fill(.mainBrown)
                                .frame(width: 128, height: 45)
                                .cornerRadius(12)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.mainYellow)
                                        .overlay {
                                            Text("Add reminder")
                                                .Madimi(size: 16, color: .white)
                                        }
                                    
                                }
                            
                            if eggHomeModel.isAddTapped {
                                Button(action: {
                                    eggHomeModel.isAddReminderTapped.toggle()
                                    eggHomeModel.isAddTapped = false
                                }) {
                                    Circle()
                                        .fill(eggHomeModel.isAddTapped ? .mainYellow : .mainBrown)
                                        .frame(width: 48, height: 48)
                                        .shadow(radius: 5, y: 5)
                                        .overlay {
                                            Image(.mark)
                                                .resizable()
                                                .frame(width: 16, height: 16)
                                        }
                                }
                            }
                        }
                        .offset(x: -8)
                        
                        HStack(spacing: 15) {
                            Rectangle()
                                .fill(.mainBrown)
                                .frame(width: 162, height: 45)
                                .cornerRadius(12)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.mainYellow)
                                        .overlay {
                                            Text("Add chicken group")
                                                .Madimi(size: 16, color: .white)
                                        }
                                    
                                }
                            
                            if eggHomeModel.isAddTapped {
                                Button(action: {
                                    eggHomeModel.isAddGroupTapped.toggle()
                                    eggHomeModel.isAddTapped = false
                                }) {
                                    Circle()
                                        .fill(eggHomeModel.isAddTapped ? .mainYellow : .mainBrown)
                                        .frame(width: 48, height: 48)
                                        .shadow(radius: 5, y: 5)
                                        .overlay {
                                            Image(.chicken)
                                                .resizable()
                                                .frame(width: 16, height: 16)
                                        }
                                }
                            }
                        }
                        .offset(x: -8)
                    }
                    
                    HStack {
                        if eggHomeModel.isAddTapped {
                            Rectangle()
                                .fill(.mainBrown)
                                .frame(width: 162, height: 45)
                                .cornerRadius(12)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.mainYellow)
                                        .overlay {
                                            Text("Add collected eggs")
                                                .Madimi(size: 16, color: .white)
                                        }
                                    
                                }
                        }
                        
                        Button(action: {
                            if eggHomeModel.isAddTapped {
                                eggHomeModel.isAddCollectTapped = true
                                eggHomeModel.isAddTapped = false
                            } else {
                                eggHomeModel.isAddTapped.toggle()
                            }
                        }) {
                            Circle()
                                .fill(eggHomeModel.isAddTapped ? .mainYellow : .mainBrown)
                                .frame(width: 64, height: 64)
                                .shadow(radius: 5, y: 5)
                                .overlay {
                                    Image(eggHomeModel.isAddTapped ? .egg : .addBtn)
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                        }
                        .disabled(UserDefaultsManager().isGuest() ? true : false)
                        .opacity(UserDefaultsManager().isGuest() ? 0.8 : 1)
                    }
                }
            }
            .position(getPosition())
        }
        .onAppear {
            loadMonthlyData()
        }
        .onChange(of: eggHomeModel.isAddCollectTapped) { _ in
            loadMonthlyData()
        }
        .fullScreenCover(isPresented: $eggHomeModel.isAddReminderTapped) {
            EggAddReminderView(isEditing: false, remindModel: eggHomeModel.model)
        }
        
        .fullScreenCover(isPresented: $eggHomeModel.isAddGroupTapped) {
            EggAddGroupView()
        }
        
        .fullScreenCover(isPresented: $eggHomeModel.isAddCollectTapped) {
            EggAddEggView()
        }
        
        .fullScreenCover(isPresented: $eggHomeModel.isEditing) {
            EggAddReminderView(isEditing: true, remindModel: eggHomeModel.model)
        }
    }
    
    func getPosition() -> CGPoint {
        if UIScreen.main.bounds.width > 900 {
            return CGPoint(x: eggHomeModel.isAddTapped ? UIScreen.main.bounds.width / 1.27 : UIScreen.main.bounds.width / 1.15,
                           y: eggHomeModel.isAddTapped ? UIScreen.main.bounds.height / 1.3 : UIScreen.main.bounds.height / 1.23)
        } else if UIScreen.main.bounds.width > 700 {
            return CGPoint(x: eggHomeModel.isAddTapped ? UIScreen.main.bounds.width / 1.3 : UIScreen.main.bounds.width / 1.15,
                           y: eggHomeModel.isAddTapped ? UIScreen.main.bounds.height / 1.305 : UIScreen.main.bounds.height / 1.23)
        } else if UIScreen.main.bounds.width < 390 {
            return CGPoint(x: eggHomeModel.isAddTapped ? UIScreen.main.bounds.width / 1.55 : UIScreen.main.bounds.width / 1.15,
                           y: eggHomeModel.isAddTapped ? UIScreen.main.bounds.height / 1.5 : UIScreen.main.bounds.height / 1.33)
        } else {
            return CGPoint(x: eggHomeModel.isAddTapped ? UIScreen.main.bounds.width / 1.52 : UIScreen.main.bounds.width / 1.15,
                           y: eggHomeModel.isAddTapped ? UIScreen.main.bounds.height / 1.46 : UIScreen.main.bounds.height / 1.33)
        }
    }
}

#Preview {
    EggHomeView()
}

struct NonRepeatView: View {
    var reminder: ReminderModel
    var body: some View {
        Rectangle()
            .fill(.white)
            .overlay {
                VStack {
                    HStack {
                        Image(getImage())
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.leading)
                        
                        Spacer()
                    }
                    .padding(.top)
                    
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(reminder.name)
                                .Madimi(size: 18)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                            
                            Text(getDateText())
                                .Madimi(size: 12, color: Color(red: 140/255, green: 118/255, blue: 103/255))
                        }
                        .padding(.bottom)
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.435, height: UIScreen.main.bounds.height * 0.188)
            .cornerRadius(24)
    }
    
    func getImage() -> String {
        switch reminder.category {
        case .first:
            return EggImageName.chicken.rawValue
        case .second:
            return EggImageName.medicine.rawValue
        case .third:
            return EggImageName.photo.rawValue
        case .fourth:
            return EggImageName.work.rawValue
        case .fifth:
            return EggImageName.mark.rawValue
        }
    }
    
    func getDateText() -> String {
        let calendar = Calendar.current
        let reminderDate = reminder.date
        let reminderTime = reminder.time
        
        if calendar.isDateInToday(reminderDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            return "Today, \(dateFormatter.string(from: reminderTime))"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yy"
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            return "\(dateFormatter.string(from: reminderDate) + ", " + timeFormatter.string(from: reminderTime))"
        }
    }
}

struct RepeatView: View {
    var reminder: ReminderModel
    
    var body: some View {
        Rectangle()
            .fill(Color(red: 189/255, green: 136/255, blue: 16/255))
            .overlay {
                VStack {
                    HStack {
                        Image(getImage())
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.leading)
                        
                        Spacer()
                    }
                    .padding(.top)
                    
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(reminder.name)
                                .Madimi(size: 18)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                            
                            Text(getDateText())
                                .Madimi(size: 12, color: Color(red: 114/255, green: 70/255, blue: 8/255))
                        }
                        .padding(.bottom)
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.435, height: UIScreen.main.bounds.height * 0.188)
            .cornerRadius(24)
    }
    
    func getImage() -> String {
        switch reminder.category {
        case .first:
            return EggImageName.chicken.rawValue
        case .second:
            return EggImageName.medicine.rawValue
        case .third:
            return EggImageName.photo.rawValue
        case .fourth:
            return EggImageName.work.rawValue
        case .fifth:
            return EggImageName.mark.rawValue
        }
    }
    
    func getDateText() -> String {
        let reminderTime = reminder.time
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        return "\(reminder.repeatTime.rawValue + ", " + timeFormatter.string(from: reminderTime))"
    }
}
