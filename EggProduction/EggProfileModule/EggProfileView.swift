import SwiftUI

struct EggProfileView: View {
    @StateObject var eggProfileModel =  EggProfileViewModel()
    var userDefaultsManager = UserDefaultsManager()
    
    var body: some View {
        ZStack {
            Color(.mainYellow)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Profile")
                        .Madimi(size: 30)
                    
                    if let image = eggProfileModel.getImageFromUserDefaults() {
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
                                                    if !userDefaultsManager.isGuest() {
                                                        eggProfileModel.isImagePick = true
                                                    }
                                                }) {
                                                    Image(.choose)
                                                        .resizable()
                                                        .frame(width: 32, height: 32)
                                                }
                                                .opacity(userDefaultsManager.isGuest() ? 0.8 : 1)
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
                                            if !userDefaultsManager.isGuest() {
                                                eggProfileModel.isImagePick = true
                                            }
                                        }) {
                                            Image(.choose)
                                                .resizable()
                                                .frame(width: 32, height: 32)
                                        }
                                        .opacity(userDefaultsManager.isGuest() ? 0.8 : 1)
                                    }
                                }
                            }
                    }
                    
                    VStack {
                        Text(userDefaultsManager.isGuest() ? "Guest" : UserDefaultsManager().getEmail() ?? "Name")
                            .Madimi(size: 24)
                        
                        if !userDefaultsManager.isGuest() {
                            Text(UserDefaultsManager().getNickname(for: UserDefaultsManager().getEmail() ?? "Email") ?? "Email")
                                .Madimi(size: 18)
                        }
                    }
                    
                    VStack {
                        HStack {
                            Text("Notification Settings")
                                .Madimi(size: 16)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Rectangle()
                            .fill(.mainBrown)
                            .overlay {
                                HStack {
                                    Text("Push Notifications")
                                        .Madimi(size: 18, color: .secondBrown)
                                    
                                    Spacer()
                                    
                                    
                                    Toggle("", isOn: $eggProfileModel.isPushNotif)
                                        .toggleStyle(CustomToggleStyle())
                                }
                                .padding(.horizontal)
                            }
                            .frame(height: 54)
                            .cornerRadius(20)
                            .padding(.horizontal)
                        
                        Rectangle()
                            .fill(.mainBrown)
                            .overlay {
                                HStack {
                                    Text("Email Notifications")
                                        .Madimi(size: 18, color: .secondBrown)
                                    
                                    Spacer()
                                    
                                    
                                    Toggle("", isOn: $eggProfileModel.isEmailNotif)
                                        .toggleStyle(CustomToggleStyle())
                                }
                                .padding(.horizontal)
                            }
                            .frame(height: 54)
                            .cornerRadius(20)
                            .padding(.horizontal)
                    }
                    .padding(.top)
                    
                    if !userDefaultsManager.isGuest() {
                        VStack(spacing: 12) {
                            Button(action: {
                                userDefaultsManager.deleteAccount()
                                eggProfileModel.isOut = true
                            }) {
                                Rectangle()
                                    .fill(.secondYellow)
                                    .overlay {
                                        HStack {
                                            Text("Delete Account")
                                                .Madimi(size: 18, color: .mainBrown)
                                        }
                                    }
                                    .frame(height: 54)
                                    .cornerRadius(20)
                                    .padding(.horizontal)
                            }
                            
                            Button(action: {
                                userDefaultsManager.logout()
                                eggProfileModel.isOut = true
                            }) {
                                Rectangle()
                                    .fill(.secondYellow)
                                    .overlay {
                                        HStack {
                                            Text("Log Out")
                                                .Madimi(size: 18, color: .mainBrown)
                                        }
                                    }
                                    .frame(height: 54)
                                    .cornerRadius(20)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.top)
                    } else {
                        Button(action: {
                            eggProfileModel.isCreate = true
                            userDefaultsManager.quitQuest()
                        }) {
                            Rectangle()
                                .fill(.white)
                                .overlay {
                                    HStack {
                                        Text("Create Account")
                                            .Madimi(size: 18, color: .mainBrown)
                                    }
                                }
                                .frame(height: 54)
                                .cornerRadius(20)
                                .padding(.horizontal)
                        }
                        .padding(.top)
                    }
                    
                    Color(.clear)
                        .frame(height: 60)
                }
                .padding(.top)
            }
        }
        .sheet(isPresented: $eggProfileModel.isImagePick) {
            ImagePicker(image: $eggProfileModel.selectedImage, isPresented: $eggProfileModel.isImagePick)
                .onDisappear {
                    if let newImage = eggProfileModel.selectedImage {
                        userDefaultsManager.saveImage(image: newImage, forEmail: userDefaultsManager.getEmail() ?? "")
                        eggProfileModel.selectedImage = nil
                    }
                }
        }
        .fullScreenCover(isPresented: $eggProfileModel.isOut, content: {
            EggOboardingView()
        })
        
        .fullScreenCover(isPresented: $eggProfileModel.isCreate, content: {
            EggCreateAccountView()
        })
    }
}


#Preview {
    EggProfileView()
}
