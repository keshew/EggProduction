import SwiftUI

struct EggCreateAccountView: View {
    @StateObject var eggCreateAccountModel =  EggCreateAccountViewModel()
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
                            if UserDefaultsManager().isGuest() {
                                eggCreateAccountModel.isOnb = true
                            } else {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Image(systemName: "arrow.left")
                                .foregroundStyle(.white)
                                .font(.title.weight(.bold))
                                .padding(.leading)
                        }
                        
                        Spacer()
                        
                        Text("Create Account")
                            .Madimi(size: 30)
                            .padding(.trailing, 50)
                        
                        Spacer()
                    }
                    
                    if let image = eggCreateAccountModel.selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .cornerRadius(48)
                            .frame(width: 96, height: 96)
                            .overlay {
                                RoundedRectangle(cornerRadius: 48)
                                    .stroke(.mainBrown, lineWidth: 4)
                                    .overlay {
                                        VStack {
                                            Spacer()
                                            HStack {
                                                Spacer()
                                                Button(action: {
                                                    eggCreateAccountModel.isImagePick = true
                                                }) {
                                                    Image(.choose)
                                                        .resizable()
                                                        .frame(width: 32, height: 32)
                                                }
                                            }
                                        }
                                    }
                            }
                    } else {
                        Image(.creating)
                            .resizable()
                            .frame(width: 96, height: 96)
                            .overlay {
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            eggCreateAccountModel.isImagePick = true
                                        }) {
                                            Image(.choose)
                                                .resizable()
                                                .frame(width: 32, height: 32)
                                        }
                                    }
                                }
                            }
                    }
                     
                    VStack(spacing: 15) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Username")
                                .Madimi(size: 16)
                                .padding(.leading)
                            
                            CustomTextFiled(text: $eggCreateAccountModel.username,
                                            placeholder: "Enter username",
                                            image: "person.fill")
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Email")
                                .Madimi(size: 16)
                                .padding(.leading)
                            
                            CustomTextFiled(text: $eggCreateAccountModel.email,
                                            placeholder: "Enter Email",
                                            image: "envelope")
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Password")
                                .Madimi(size: 16)
                                .padding(.leading)
                            
                            CustomSecureField(text: $eggCreateAccountModel.password,
                                            placeholder: "Enter Password")
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Password")
                                .Madimi(size: 16)
                                .padding(.leading)
                            
                            CustomSecureField(text: $eggCreateAccountModel.confirmPassword,
                                            placeholder: "Confirm Password")
                        }
                    }
                    .padding(.top)
                    
                    VStack(spacing: 15) {
                        Button(action: {
                            if eggCreateAccountModel.email.isEmpty ||
                               eggCreateAccountModel.password.isEmpty ||
                               eggCreateAccountModel.confirmPassword.isEmpty ||
                               eggCreateAccountModel.username.isEmpty {
                                showAlert = true
                                alertMessage = "Please fill all fields"
                            } else if eggCreateAccountModel.password == eggCreateAccountModel.confirmPassword {
                                let success = UserDefaultsManager().register(email: eggCreateAccountModel.email,
                                                                             password: eggCreateAccountModel.password,
                                                                             nickname: eggCreateAccountModel.username,
                                                                             image: eggCreateAccountModel.selectedImage)
                                if success {
                                    eggCreateAccountModel.isLog = true
                                } else {
                                    showAlert = true
                                    alertMessage = "Registration failed"
                                }
                            } else {
                                showAlert = true
                                alertMessage = "Passwords do not match"
                            }
                        }) {
                            Rectangle()
                                .fill(.white)
                                .frame(height: 54)
                                .cornerRadius(20)
                                .padding(.horizontal)
                                .overlay {
                                    Text("Create Account")
                                        .Madimi(size: 18)
                                }
                        }
                        
                        Button(action: {
                            eggCreateAccountModel.isLog = true
                        }) {
                            Rectangle()
                                .fill(.secondYellow)
                                .frame(height: 54)
                                .cornerRadius(20)
                                .padding(.horizontal)
                                .overlay {
                                    Text("Log In")
                                        .Madimi(size: 18)
                                }
                        }
                        
                        Button(action: {
                            eggCreateAccountModel.isGuest = true
                            UserDefaultsManager().enterAsGuest()
                        }) {
                            Rectangle()
                                .fill(.secondYellow)
                                .frame(height: 54)
                                .cornerRadius(20)
                                .padding(.horizontal)
                                .overlay {
                                    Text("Guest Access")
                                        .Madimi(size: 18)
                                }
                        }
                    }
                    .padding(.top, 20)
                }
                
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        
        .sheet(isPresented: $eggCreateAccountModel.isImagePick) {
            ImagePicker(image: $eggCreateAccountModel.selectedImage, isPresented: $eggCreateAccountModel.isImagePick)
        }
        .fullScreenCover(isPresented: $eggCreateAccountModel.isGuest) {
            EggTabBarView()
        }
        .fullScreenCover(isPresented: $eggCreateAccountModel.isOnb) {
            EggOboardingView()
        }
        .fullScreenCover(isPresented: $eggCreateAccountModel.isLog) {
            EggLogView()
        }
    }
}

#Preview {
    EggCreateAccountView()
}
