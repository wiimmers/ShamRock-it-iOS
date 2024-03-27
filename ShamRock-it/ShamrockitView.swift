//
//  ContentView.swift
//  ShamRock-it
//
//  Created by Nicholas Wimmers on 3/8/24.
//

import SwiftUI

struct ShamrockitView: View {
    
    @State var currentPage: Int = 3
    @EnvironmentObject var user: MockUser
    
    var body: some View {
        
        
        ZStack {
            
            BackgroundGradient()
            
            VStack {
                
                Spacer()
            
                Image("shamrockit")
                
                Spacer()
                
                switch (currentPage) {
                case 0:
                    PageOne(email: $user.email,
                            knowsPcName: $user.knowsPcName,
                            currentPage: $currentPage)
                    
                case 1:
                    PageTwo(loginCode: $user.loginCode,
                            knowsPcName: $user.knowsPcName,
                            currentPage: $currentPage)
                    
                case 2:
                    PageThree(firstName: $user.firstName,
                              lastName: $user.lastName,
                              email: $user.email,
                              ext: $user.ext,
                              currentPage: $currentPage,
                              knowsPcName: $user.knowsPcName)
                    
                case 3:
                    PageFour(knowsPcName: $user.knowsPcName,
                             pcName: $user.pcName,
                             currentPage: $currentPage)
                    
                case 4:
                    PageFive(currentPage: $currentPage,
                             knowsPcName: $user.knowsPcName,
                             pcName: $user.pcName)
                    
                case 5:
                    PageSix(currentPage: $currentPage,
                            knowsPcName: $user.knowsPcName,
                            input: $user.userRequest)
                
                case 6:
                    ServiceTagHelpView(currentPage: $currentPage,
                                       knowsPcName: $user.knowsPcName)
                    
                default:
                    PageOne(email: $user.email,
                            knowsPcName: $user.knowsPcName,
                            currentPage: $currentPage)
                }
                
                Spacer()
            }.onAppear {
                if user.hasLoginCode == false {
                    currentPage = 0
                } else {
                    currentPage = 2
                }
            }
        }
    }
}

#Preview {
    ShamrockitView().environmentObject(MockUser())
        
}

struct BackgroundGradient: View {
    
    var body: some View {
        
        LinearGradient(gradient: Gradient(colors:[Color("tungsten"),Color("iron")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

struct HeaderText: View {
    
    var text: String
    
    var body: some View {
        
        Text("\(text)")
            .font(.system(size:24))
            .fontWeight(.heavy)
            .foregroundColor(Color("sweeneyYellow"))
    }
}

struct CheckmarkToggle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            configuration
                .label
                .font(.system(size: 24))
                .fontWeight(.heavy)
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .background(Color(.white))
                .foregroundColor(Color("sweeneyGreen"))
                .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                .onTapGesture { 
                    configuration.isOn.toggle()
                }
        }
    }
}
