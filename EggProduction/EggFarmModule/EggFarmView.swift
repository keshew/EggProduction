import SwiftUI

struct EggFarmView: View {
    @StateObject var eggFarmModel =  EggFarmViewModel()
    
    var body: some View {
        ZStack {
            Color(.mainYellow)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Farm")
                        .Madimi(size: 30)
                    
                    if let groups = UserDefaultsManager().loadGroups() {
                        ForEach(groups) { group in
                            FarmView(group: group)
                                .onTapGesture {
                                    eggFarmModel.isGroup = true
                                    eggFarmModel.group = group
                                }
                        }
                    } else {
                        Text("No groups yet")
                            .Madimi(size: 30)
                            .padding(.top)
                    }
                    
                    Color(.clear)
                        .frame(height: 60)
                }
                .padding(.top)
            }
            
            if eggFarmModel.isAddTapped {
                Color.mainBrown
                    .ignoresSafeArea()
                    .opacity(0.7)
                    .onTapGesture {
                        eggFarmModel.isAddTapped.toggle()
                    }
            }
            
            VStack(spacing: 10) {
                VStack(alignment: .trailing, spacing: 10) {
                    if eggFarmModel.isAddTapped {
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
                            
                            if eggFarmModel.isAddTapped {
                                Button(action: {
                                    eggFarmModel.isAddReminderTapped.toggle()
                                    eggFarmModel.isAddTapped = false
                                }) {
                                    Circle()
                                        .fill(eggFarmModel.isAddTapped ? .mainYellow : .mainBrown)
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
                                            Text("Add collected eggs")
                                                .Madimi(size: 16, color: .white)
                                        }
                                    
                                }
                            
                            if eggFarmModel.isAddTapped {
                                Button(action: {
                                    eggFarmModel.isAddCollectTapped.toggle()
                                    eggFarmModel.isAddTapped = false
                                }) {
                                    Circle()
                                        .fill(eggFarmModel.isAddTapped ? .mainYellow : .mainBrown)
                                        .frame(width: 48, height: 48)
                                        .shadow(radius: 5, y: 5)
                                        .overlay {
                                            Image(.egg)
                                                .resizable()
                                                .frame(width: 16, height: 16)
                                        }
                                }
                            }
                        }
                        .offset(x: -8)
                    }
                    
                    HStack {
                        if eggFarmModel.isAddTapped {
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
                        }
                        
                        Button(action: {
                            if eggFarmModel.isAddTapped {
                                eggFarmModel.isAddGroupTapped = true
                                eggFarmModel.isAddTapped = false
                            } else {
                                eggFarmModel.isAddTapped.toggle()
                            }
                        }) {
                            Circle()
                                .fill(eggFarmModel.isAddTapped ? .mainYellow : .mainBrown)
                                .frame(width: 64, height: 64)
                                .shadow(radius: 5, y: 5)
                                .overlay {
                                    Image(eggFarmModel.isAddTapped ? .chicken : .addBtn)
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                        }
                        .disabled(UserDefaultsManager().isGuest() ? true : false)
                        .opacity(UserDefaultsManager().isGuest() ? 0.8 : 1)
                    }
                }
            }
            .position(x: eggFarmModel.isAddTapped ? UIScreen.main.bounds.width / 1.52 : UIScreen.main.bounds.width / 1.15,
                      y: eggFarmModel.isAddTapped ? UIScreen.main.bounds.height / 1.46 : UIScreen.main.bounds.height / 1.33)
        }
        .fullScreenCover(isPresented: $eggFarmModel.isAddReminderTapped) {
            EggAddReminderView(isEditing: false, remindModel: eggFarmModel.model)
        }
        
        .fullScreenCover(isPresented: $eggFarmModel.isAddGroupTapped) {
            EggAddGroupView()
        }
        
        .fullScreenCover(isPresented: $eggFarmModel.isAddCollectTapped) {
            EggAddEggView()
        }
        
        .fullScreenCover(isPresented: $eggFarmModel.isGroup) {
            EggGroupView(groupModel: eggFarmModel.group)
        }
    }
}

#Preview {
    EggFarmView()
}

struct FarmView: View {
    var group: ChikenGroupModel
    
    var body: some View {
        Rectangle()
            .fill(.white)
            .frame(height: 90)
            .cornerRadius(20)
            .overlay {
                HStack {
                    Circle()
                        .fill(.mainYellow)
                        .frame(width: 48, height: 48)
                        .shadow(radius: 5, y: 3)
                        .overlay {
                            Image(.egg)
                                .resizable()
                                .frame(width: 16, height: 16)
                        }
                    
                    VStack(alignment: .leading) {
                        Text(group.name)
                            .Madimi(size: 24)
                        
                        Text(formatDate(group.date))
                            .Madimi(size: 18, color: .secondBrown)
                    }
                    .padding(.leading, 5)
                    
                    Spacer()
                    
                    Text("\(calculateTotalEggs(group: group))")
                        .Madimi(size: 24)
                }
                .padding(.horizontal)
            }
            .padding(.horizontal)
            .padding(.vertical, 2)
    }
    
    func calculateTotalEggs(group: ChikenGroupModel) -> Int {
        return group.eggMade.values.reduce(0, +)
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}
