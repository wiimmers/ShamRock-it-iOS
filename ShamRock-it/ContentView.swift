//
//  ContentView.swift
//  ShamRock-it
//
//  Created by Nicholas Wimmers on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    @State var currentPage: Int = 0
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var ext: String = ""
    
    @State var loginCode: String = ""
    
    @State var knowsPcName: Bool = false
    @State var pcName: String = ""
    
    var body: some View {
        
        ZStack {
            
            BackgroundGradient()
            
            VStack {
                
                Spacer()
            
                Image("shamrockit")
                
                Spacer()
                
                switch (currentPage) {
                case 0:
                    PageOne(email: $email,
                            currentPage: $currentPage)
                    
                case 1:
                    PageTwo(loginCode: $loginCode,
                            currentPage: $currentPage)
                    
                case 2:
                    PageThree(firstName: $firstName,
                              lastName: $lastName,
                              email: $email,
                              ext: $ext,
                              currentPage: $currentPage)
                    
                case 3:
                    PageFour(knowsPcName: $knowsPcName,
                             pcName: $pcName,
                             currentPage: $currentPage)
                    
                default:
                    PageOne(email: $email,
                            currentPage: $currentPage)
                }
                
                Spacer()
            }
        }
    }
}

func resetPages() -> Int {
    return 0
}

#Preview {
    ContentView()
}

struct BackgroundGradient: View {
    
    var body: some View {
        
        LinearGradient(gradient: Gradient(colors: [Color("tungsten"), Color("iron")]), startPoint: .topLeading, endPoint: .bottomTrailing)
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
                .background(Color("sweeneyGreen"))
                .foregroundColor(Color("sweeneyYellow"))
                .cornerRadius(5)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}
