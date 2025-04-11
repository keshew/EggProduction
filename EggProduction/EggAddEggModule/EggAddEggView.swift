import SwiftUI

struct EggAddEggView: View {
    @StateObject var eggAddEggModel =  EggAddEggViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedGroupId: String?
    @State private var showAlert = false
    @State private var alertMessage = ""
    var userDefaultsManager = UserDefaultsManager()
    
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
                        
                        Text("New egg")
                            .Madimi(size: 30)
                            .padding(.leading)
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 20) {
                        CustomTextFiled3(text: $eggAddEggModel.numberOfEgg,
                                         placeholder: "Enter number of egg",
                                         image: EggImageName.tab1Picked.rawValue)
                        
                        VStack(spacing: 6) {
                            HStack {
                                Text("Group")
                                    .Madimi(size: 16)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    Button(action: {
                                        eggAddEggModel.isAdd = true
                                    }) {
                                        Rectangle()
                                            .fill(.secondYellow)
                                            .frame(width: 52, height: 48)
                                            .cornerRadius(10)
                                            .overlay {
                                                Image(systemName: "plus")
                                                    .font(.system(size: 26, weight: .bold))
                                                    .foregroundStyle(.mainBrown)
                                            }
                                    }
                                    
                                    if let groups = userDefaultsManager.loadGroups() {
                                        ForEach(groups) { group in
                                            Button(action: {
                                                selectedGroupId = group.id
                                            }) {
                                                Rectangle()
                                                    .fill(.secondYellow)
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(.white, lineWidth: selectedGroupId == group.id ? 2 : 0)
                                                            .overlay {
                                                                Image(group.icon)
                                                                    .resizable()
                                                                    .frame(width: 24, height: 24)
                                                            }
                                                        
                                                    }
                                                    .frame(width: 52, height: 48)
                                                    .cornerRadius(10)
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        VStack {
                            HStack {
                                Text("Comment")
                                    .Madimi(size: 16)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            CustomTextView(text: $eggAddEggModel.comment,
                                           placeholder: "Add comment")
                        }
                    }
                    
                    Spacer(minLength: 250)
                    
                    Button(action: {
                        if let groupId = selectedGroupId, !eggAddEggModel.numberOfEgg.isEmpty {
                            if let count = Int(eggAddEggModel.numberOfEgg) {
                                userDefaultsManager.addEggToGroup(withId: groupId, date: Date(), count: count)
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                alertMessage = "Please enter a valid number"
                                showAlert = true
                            }
                        } else {
                            alertMessage = "Please select a group and enter a number"
                            showAlert = true
                        }
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
        .fullScreenCover(isPresented: $eggAddEggModel.isAdd) {
            EggAddGroupView()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}


#Preview {
    EggAddEggView()
}

