import SwiftUI

struct EggLogView: View {
    @StateObject var eggLogModel =  EggLogViewModel()
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
                        
                        Spacer()
                        
                        Text("Log In")
                            .Madimi(size: 30)
                            .padding(.trailing, 50)
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Email")
                                .Madimi(size: 16)
                                .padding(.leading)
                            
                            CustomTextFiled(text: $eggLogModel.email,
                                            placeholder: "Enter Email",
                                            image: "envelope")
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Password")
                                .Madimi(size: 16)
                                .padding(.leading)
                            
                            CustomSecureField(text: $eggLogModel.password,
                                            placeholder: "Enter Password")
                        }
                    }
                    .padding(.top)
                    
                    VStack(spacing: 15) {
                        Button(action: {
                            if UserDefaultsManager().login(email: eggLogModel.email, password: eggLogModel.password) {
                                eggLogModel.isTabBar = true
                            } else {
                                showAlert = true
                                alertMessage = "User already exist"
                            }
                        }) {
                            Rectangle()
                                .fill(.white)
                                .frame(height: 54)
                                .cornerRadius(20)
                                .padding(.horizontal)
                                .overlay {
                                    Text("Log In")
                                        .Madimi(size: 18)
                                }
                        }
                        
                        Button(action: {
                            eggLogModel.isCreate = true
                        }) {
                            Rectangle()
                                .fill(.secondYellow)
                                .frame(height: 54)
                                .cornerRadius(20)
                                .padding(.horizontal)
                                .overlay {
                                    Text("Create Account")
                                        .Madimi(size: 18)
                                }
                        }
                        
                        Button(action: {
                            eggLogModel.isGuest = true
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
                .padding(.top)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        
        .fullScreenCover(isPresented: $eggLogModel.isGuest) {
            EggTabBarView()
        }
        .fullScreenCover(isPresented: $eggLogModel.isCreate) {
            EggCreateAccountView()
        }
        
        .fullScreenCover(isPresented: $eggLogModel.isTabBar) {
            EggTabBarView()
        }
    }
}

#Preview {
    EggLogView()
}
