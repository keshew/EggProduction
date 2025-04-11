import SwiftUI

struct CustomTextFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    var image: String
    var body: some View {
        ZStack(alignment: .leading) {
            if isTextFocused {
                Rectangle()
                    .fill(.mainBrown)
                    .frame(height: 54)
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white, lineWidth: 2)
                            
                    }
                    .padding(.horizontal, 15)
            } else {
                Rectangle()
                    .fill(.mainBrown)
                    .frame(height: 54)
                    .cornerRadius(20)
                    .padding(.horizontal, 15)
            }
            
            TextField("", text: $text, onEditingChanged: { isEditing in
                if !isEditing {
                    isTextFocused = false
                }
            })
            .padding(.horizontal, 16)
            .frame(height: 54)
            .font(.custom("MadimiOne-Regular", size: 15))
            .cornerRadius(20)
            .foregroundStyle(.secondYellow)
            .focused($isTextFocused)
            .padding(.horizontal, 15)
            .padding(.leading, 30)
            
            HStack(spacing: -13) {
                Image(systemName: image)
                    .foregroundStyle(!text.isEmpty ? .secondYellow : .secondBrown)
                    .frame(width: 16, height: 16)
                    .padding(.leading, 30)
                
                if text.isEmpty && !isTextFocused {
                    Text(placeholder)
                        .Madimi(size: 16, color: .secondBrown)
                        .padding(.leading, 30)
                        .onTapGesture {
                            isTextFocused = true
                        }
                }
            }
            .padding(.leading, 5)
        }
        .frame(height: 54)
    }
}

struct CustomTextFiled3: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    var image: String
    var body: some View {
        ZStack(alignment: .leading) {
            if isTextFocused {
                Rectangle()
                    .fill(.mainBrown)
                    .frame(height: 54)
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white, lineWidth: 2)
                            
                    }
                    .padding(.horizontal, 15)
            } else {
                Rectangle()
                    .fill(.mainBrown)
                    .frame(height: 54)
                    .cornerRadius(20)
                    .padding(.horizontal, 15)
            }
            
            TextField("", text: $text, onEditingChanged: { isEditing in
                if !isEditing {
                    isTextFocused = false
                }
            })
            .keyboardType(.numberPad)
            .padding(.horizontal, 16)
            .frame(height: 54)
            .font(.custom("MadimiOne-Regular", size: 15))
            .cornerRadius(20)
            .foregroundStyle(.secondYellow)
            .focused($isTextFocused)
            .padding(.horizontal, 15)
            .padding(.leading, 30)
            
            HStack(spacing: -13) {
                Image(image)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .padding(.leading, 30)
                
                if text.isEmpty && !isTextFocused {
                    Text(placeholder)
                        .Madimi(size: 16, color: .secondBrown)
                        .padding(.leading, 30)
                        .onTapGesture {
                            isTextFocused = true
                        }
                }
            }
            .padding(.leading, 5)
        }
        .frame(height: 54)
    }
}

struct CustomTextFiled2: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    var body: some View {
        ZStack(alignment: .leading) {
            if isTextFocused {
                Rectangle()
                    .fill(.mainBrown)
                    .frame(height: 54)
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white, lineWidth: 2)
                            
                    }
                    .padding(.horizontal, 15)
            } else {
                Rectangle()
                    .fill(.mainBrown)
                    .frame(height: 54)
                    .cornerRadius(20)
                    .padding(.horizontal, 15)
            }
            
            TextField("", text: $text, onEditingChanged: { isEditing in
                if !isEditing {
                    isTextFocused = false
                }
            })
            .padding(.horizontal, 16)
            .frame(height: 54)
            .font(.custom("MadimiOne-Regular", size: 18))
            .cornerRadius(20)
            .foregroundStyle(.secondYellow)
            .focused($isTextFocused)
            .padding(.horizontal, 15)
            .padding(.leading, 5)
            
            HStack(spacing: -13) {
                if text.isEmpty && !isTextFocused {
                    Text(placeholder)
                        .Madimi(size: 18, color: .secondBrown)
                        .padding(.leading, 30)
                        .onTapGesture {
                            isTextFocused = true
                        }
                }
            }
            .padding(.leading, 5)
        }
        .frame(height: 54)
    }
}

struct CustomSecureField: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if isTextFocused {
                Rectangle()
                    .fill(.mainBrown)
                    .frame(height: 54)
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white, lineWidth: 2)
                            
                    }
                    .padding(.horizontal, 15)
            } else {
                Rectangle()
                    .fill(.mainBrown)
                    .frame(height: 54)
                    .cornerRadius(20)
                    .padding(.horizontal, 15)
            }
            
            SecureField("", text: $text)
            .padding(.horizontal, 16)
            .font(.custom("MadimiOne-Regular", size: 16))
            .cornerRadius((20))
            .foregroundStyle(.secondYellow)
            .focused($isTextFocused)
            .padding(.horizontal, 15)
            .padding(.leading, 30)
            
            HStack(spacing: -13) {
                Image(!text.isEmpty ? .locked2 : .locked)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .padding(.leading, 30)
                
                if text.isEmpty && !isTextFocused {
                    Text(placeholder)
                        .Madimi(size: 16, color: .secondBrown)
                        .padding(.leading, 30)
                        .onTapGesture {
                            isTextFocused = true
                        }
                }
            }
            .padding(.leading, 5)
        }
        .frame(height: 54)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        if !isPresented {
            uiViewController.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? .mainYellow : Color(red: 103/255, green: 103/255, blue: 103/255))
                .frame(width: 48, height: 24)
                .overlay(
                    Circle()
                        .fill(Color(red: 19/255, green: 19/255, blue: 19/255))
                        .frame(width: 16, height: 16)
                        .offset(x: configuration.isOn ? 12 : -12)
                        .animation(.easeInOut, value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabType
    
    enum TabType: Int {
        case Home
        case Farm
        case Profile
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(red: 64/255, green: 26/255, blue: 2/255)
                .frame(height: 100)
                .edgesIgnoringSafeArea(.bottom)
                .offset(y: 35)
            
            HStack(spacing: 0) {
                TabBarItem(imageName: "tab1", tab: .Home, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab2", tab: .Farm, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab3", tab: .Profile, selectedTab: $selectedTab)
            }
            .padding(.top, 5)
            .frame(height: 60)
        }
    }
}

struct TabBarItem: View {
    let imageName: String
    let tab: CustomTabBar.TabType
    @Binding var selectedTab: CustomTabBar.TabType
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 8) {
                Image(selectedTab == tab ? imageName + "Picked" : imageName)
                    .resizable()
                    .frame(width: 24, height: 24)
                
                Text("\(tab)")
                    .Madimi(size: 12,
                            color: selectedTab == tab ? Color(red: 255/255, green: 188/255, blue: 6/255) : .secondBrown)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct DateTF: View {
    @Binding var date: Date
    var text: String

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.mainBrown)
                    .frame(width: 175, height: 54)
                    .cornerRadius(20)
                
                HStack {
                    if date.timeIntervalSince1970 == 0 {
                        Text("Date")
                            .Madimi(size: 18, color: .secondBrown)
                        Spacer()
                    } else {
                        Text(formattedDate(date: date))
                            .Madimi(size: 18, color: .secondBrown)
                    }
                    
           
                }
                .padding(.horizontal)
                
                DatePicker(
                    "Date",
                    selection: $date,
                    in: Date()...,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.compact)
                .colorMultiply(.clear)
                .frame(width: 175, height: 54)
            }
            .labelsHidden()
            .frame(width: 175, height: 54)
        }
    }
    
    func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
}

struct TimeTF: View {
    @Binding var time: Date
    var text: String

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.mainBrown)
                    .frame(width: 175, height: 54)
                    .cornerRadius(20)
                
                HStack {
                    if time.timeIntervalSince1970 == 0 {
                        Text("Time")
                            .Madimi(size: 18, color: .secondBrown)
                        Spacer()
                    } else {
                        Text(time.formatted(date: .omitted, time: .shortened))
                            .Madimi(size: 18, color: .secondBrown)
                    }
                }
                .padding(.horizontal)
                
                DatePicker(
                    "Time",
                    selection: $time,
                    in: Date()...,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(.compact)
                .colorMultiply(.clear)
                .frame(width: 175, height: 54)
            }
            .labelsHidden()
            .frame(width: 175, height: 54)
        }
    }
}
