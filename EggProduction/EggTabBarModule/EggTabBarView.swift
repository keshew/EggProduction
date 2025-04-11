import SwiftUI

struct EggTabBarView: View {
    @StateObject var eggTabBarModel =  EggTabBarViewModel()
    @State private var selectedTab: CustomTabBar.TabType = .Home
    @AppStorage("isEgg") private var isEgg = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if selectedTab == .Home {
                    EggHomeView()
                } else if selectedTab == .Farm {
                    EggFarmView()
                } else if selectedTab == .Profile {
                    EggProfileView()
                }
            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 0)
            }
            
            if isEgg {
                EggAlarmView()
                    .ignoresSafeArea()
            }
            
            CustomTabBar(selectedTab: $selectedTab)
                .offset(y: isEgg ? 590 : 0)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    EggTabBarView()
}
