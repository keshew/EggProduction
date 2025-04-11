import SwiftUI

struct EggGroupView: View {
    @StateObject var eggGroupModel =  EggGroupViewModel()
    @Environment(\.presentationMode) var presentationMode
    var groupModel: ChikenGroupModel
    
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
                        
                        Text(groupModel.name)
                            .Madimi(size: 30)
                        
                        Spacer()
                    }
                    
                    Rectangle()
                        .fill(.mainBrown)
                        .overlay(content: {
                            HStack(spacing: 15) {
                                Image(.tab1)
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                
                                Text("\(eggGroupModel.calculateTotalEggs(group: groupModel))")
                                    .Madimi(size: 48, color: .mainYellow)
                                
                                Spacer()
                            }
                            .padding(.leading)
                        })
                        .frame(height: 95)
                        .cornerRadius(20)
                        .padding(.horizontal)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Added")
                                .Madimi(size: 16)
                                .padding(.leading)
                            
                            Rectangle()
                                .fill(.mainBrown)
                                .frame(height: 54)
                                .cornerRadius(20)
                                .overlay {
                                    HStack {
                                        Text(eggGroupModel.formatDate(groupModel.date))
                                            .Madimi(size: 18, color: .secondBrown)
                                            .padding(.leading)
                                        
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal)
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("First egg")
                                .Madimi(size: 16)
                                .padding(.leading)
                            
                            Rectangle()
                                .fill(.mainBrown)
                                .frame(height: 54)
                                .cornerRadius(20)
                                .overlay {
                                    HStack {
                                        if let firstDate = groupModel.eggMade.keys.min() {
                                            Text(eggGroupModel.formatDate(firstDate))
                                                .Madimi(size: 18, color: .secondBrown)
                                                .padding(.leading)
                                        } else {
                                            Text("No eggs yet")
                                                .Madimi(size: 18, color: .secondBrown)
                                                .padding(.leading)
                                        }
                                        
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                    
                    Spacer(minLength: 15)
                    
                    if !groupModel.eggMade.isEmpty {
                        ForEach(groupModel.eggMade.sorted(by: { $0.key < $1.key }), id: \.key) { date, count in
                            Rectangle()
                                .fill(.white)
                                .frame(height: 64)
                                .cornerRadius(20)
                                .overlay {
                                    HStack {
                                        Text(eggGroupModel.formatDate(date))
                                            .Madimi(size: 18, color: .secondBrown)
                                        
                                        Spacer()
                                        
                                        Text("\(count)")
                                            .Madimi(size: 24)
                                    }
                                    .padding(.horizontal)
                                }
                                .padding(.horizontal)
                                .padding(.top, 5)
                        }
                    } else {
                        Text("No eggs yet")
                            .Madimi(size: 18)
                            .padding(30)
                    }
                }
                .padding(.top)
            }
        }
    }
    
  
}


#Preview {
    EggGroupView(groupModel: ChikenGroupModel(date: Date(), name: "", eggMade: [:], icon: ""))
}

