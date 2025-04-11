import SwiftUI

struct EggAddGroupView: View {
    @StateObject var eggAddGroupModel =  EggAddGroupViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var alertMessage = ""
    
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
                        
                        Text("New Chicken Group")
                            .Madimi(size: 30)
                            .padding(.leading)
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 20) {
                        VStack(spacing: 6) {
                            HStack {
                                Text("Name")
                                    .Madimi(size: 18)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            CustomTextFiled2(text: $eggAddGroupModel.name,
                                             placeholder: "Enter group name")
                        }
                        
                        VStack(spacing: 6) {
                            HStack {
                                Text("Icon")
                                    .Madimi(size: 16)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            HStack(spacing: 27) {
                                Button(action: {
                                    eggAddGroupModel.first = true
                                    eggAddGroupModel.second = false
                                    eggAddGroupModel.third = false
                                    eggAddGroupModel.fourth = false
                                    eggAddGroupModel.fifth = false
                                }) {
                                    Rectangle()
                                        .fill(.secondYellow)
                                        .frame(width: 52, height: 48)
                                        .cornerRadius(10)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.white, lineWidth: eggAddGroupModel.first ? 1 : 0)
                                            
                                            Image(.chicken)
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                        }
                                }
                                .padding(.leading, UIScreen.main.bounds.width > 700 ? 15 : 0)
                                
                                Button(action: {
                                    eggAddGroupModel.first = false
                                    eggAddGroupModel.second = true
                                    eggAddGroupModel.third = false
                                    eggAddGroupModel.fourth = false
                                    eggAddGroupModel.fifth = false
                                }) {
                                    Rectangle()
                                        .fill(.secondYellow)
                                        .frame(width: 52, height: 48)
                                        .cornerRadius(10)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.white, lineWidth: eggAddGroupModel.second ? 1 : 0)
                                            
                                            Image(.medicine)
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                        }
                                }
                                
                                Button(action: {
                                    eggAddGroupModel.first = false
                                    eggAddGroupModel.second = false
                                    eggAddGroupModel.third = true
                                    eggAddGroupModel.fourth = false
                                    eggAddGroupModel.fifth = false
                                }) {
                                    Rectangle()
                                        .fill(.secondYellow)
                                        .frame(width: 52, height: 48)
                                        .cornerRadius(10)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.white, lineWidth: eggAddGroupModel.third ? 1 : 0)
                                            
                                            Image(.photo)
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                        }
                                }
                                
                                Button(action: {
                                    eggAddGroupModel.first = false
                                    eggAddGroupModel.second = false
                                    eggAddGroupModel.third = false
                                    eggAddGroupModel.fourth = true
                                    eggAddGroupModel.fifth = false
                                }) {
                                    Rectangle()
                                        .fill(.secondYellow)
                                        .frame(width: 52, height: 48)
                                        .cornerRadius(10)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.white, lineWidth: eggAddGroupModel.fourth ? 1 : 0)
                                            
                                            Image(.work)
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                        }
                                }
                                
                                Button(action: {
                                    eggAddGroupModel.first = false
                                    eggAddGroupModel.second = false
                                    eggAddGroupModel.third = false
                                    eggAddGroupModel.fourth = false
                                    eggAddGroupModel.fifth = true
                                }) {
                                    Rectangle()
                                        .fill(.secondYellow)
                                        .frame(width: 52, height: 48)
                                        .cornerRadius(10)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.white, lineWidth: eggAddGroupModel.fifth ? 1 : 0)
                                            
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
                        
                        VStack(spacing: 6) {
                            HStack {
                                Text("Comment")
                                    .Madimi(size: 18)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            CustomTextView(text: $eggAddGroupModel.desc, placeholder: "Add comment")
                        }
                    }
                    .padding(.top)
                    
                    Spacer(minLength: 210)
                    
                    Button(action: {
                        if eggAddGroupModel.name.isEmpty || eggAddGroupModel.desc.isEmpty {
                            alertMessage = "Please fill in all fields"
                            showAlert = true
                            return
                        }
                        
                        var icon = EggImageName.addBtn.rawValue
                        if eggAddGroupModel.first {
                            icon = EggImageName.chicken.rawValue
                        } else if eggAddGroupModel.second {
                            icon = EggImageName.medicine.rawValue
                        } else if eggAddGroupModel.third {
                            icon = EggImageName.photo.rawValue
                        } else if eggAddGroupModel.fourth {
                            icon = EggImageName.work.rawValue
                        } else if eggAddGroupModel.fifth {
                            icon = EggImageName.mark.rawValue
                        }
                        
                        let group = ChikenGroupModel(
                            id: UUID().uuidString,
                            date: Date(),
                            name: eggAddGroupModel.name,
                            eggMade: [:],
                            icon: icon
                        )
                        
                        UserDefaultsManager().appendGroupToSavedGroups(group)
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
    EggAddGroupView()
}

struct CustomTextView: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String

    var body: some View {
        ZStack(alignment: .leading) {
            if isTextFocused {
                Rectangle()
                    .fill(.mainBrown)
                    .frame(height: 180)
                    .cornerRadius(12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.white, lineWidth: 2)
                    }
                    .padding(.horizontal)
            } else {
                Rectangle()
                    .fill(.mainBrown)
                    .frame(height: 180)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .background(.mainBrown)
                .padding(.horizontal, 30)
                .padding(.top, 5)
                .frame(height: 180)
                .font(.custom("MadimiOne-Regular", size: 18))
                .foregroundColor(.secondYellow)
                .focused($isTextFocused)
            
            if text.isEmpty && !isTextFocused {
                VStack {
                    Text(placeholder)
                        .font(.custom("MadimiOne-Regular", size: 18))
                        .foregroundStyle(.secondBrown)
                        .padding(.leading, 30)
                        .padding(.top)
                        .onTapGesture {
                            isTextFocused = true
                        }
                    Spacer()
                }
            }
        }
    }
}
