import SwiftUI

struct EggOboardingView: View {
    @StateObject var eggOboardingModel =  EggOboardingViewModel()

    var body: some View {
        ZStack {
            Color(.mainYellow)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Chicken Egg Production")
                        .Madimi(size: 30)
                    
                    Image(.ob1)
                        .resizable()
                        .frame(width: 340, height: 340)
                    
                    Text("Control your farm production\nwith easy and comprehensive\ntools!")
                        .Madimi(size: 24)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                    
                    Spacer(minLength: 70)
                    
                    VStack(spacing: 12) {
                        Button(action: {
                            eggOboardingModel.isStart = true
                            UserDefaultsManager().enterAsGuest()
                        }) {
                            Rectangle()
                                .fill(.white)
                                .frame(height: 54)
                                .cornerRadius(20)
                                .padding(.horizontal, 30)
                                .overlay {
                                    Text("Get started!")
                                        .Madimi(size: 18)
                                }
                        }
                        
                        Button(action: {
                            eggOboardingModel.isLog = true
                        }) {
                            Rectangle()
                                .fill(.secondYellow)
                                .frame(height: 54)
                                .cornerRadius(20)
                                .padding(.horizontal, 30)
                                .overlay {
                                    Text("Log In")
                                        .Madimi(size: 18)
                                }
                        }
                        
                        Text("if you want to see full information about your productivity")
                            .Madimi(size: 12)
                    }
                }
                .padding(.top)
            }
       
        }
        .fullScreenCover(isPresented: $eggOboardingModel.isLog) {
            EggLogView()
        }
        .fullScreenCover(isPresented: $eggOboardingModel.isStart) {
            EggTabBarView()
        }
    }
}

#Preview {
    EggOboardingView()
}

