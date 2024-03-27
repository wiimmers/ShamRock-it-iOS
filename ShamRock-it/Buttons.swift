//
//  Buttons.swift
//  ShamRock-it
//
//  Created by Nicholas Wimmers on 3/10/24.
//

import SwiftUI

struct SweeneyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(height: 30)
            .background(LinearGradient(gradient: Gradient(colors: [Color("sweeneyGreen"), Color("forest")]), startPoint: .top, endPoint: .bottom))
            .foregroundColor(Color("sweeneyYellow"))
            .font(.system(size: 20))
            .cornerRadius(30)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                .stroke(Color.clear, lineWidth: 2)
            )
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
    }
}

struct BackButton: View {
    
    @Binding var currentPage: Int
    @Binding var knowsPcName: Bool
    
    var body: some View {
        
        Button("Back") {
            if knowsPcName && currentPage == 5 {
                currentPage = 3
            } else if currentPage != 6 {
                currentPage -= 1
            } else {
                currentPage = 4
            }
        }.buttonStyle(SweeneyButtonStyle())
    }
    
}

struct SendCodeButton: View {
    @EnvironmentObject var user: MockUser
    
    @Binding var currentPage: Int
    @Binding var knowsPcName: Bool
    @Binding var showErrorText: Bool
    
    var body: some View {
        
        Button("Send", action: {
            if !user.email.contains("@jakesweeney.com") {
                showErrorText = true
            } else {
                codeMailer(recipient: user.email, loginCode: $user.loginCode)
                currentPage += 1
            }
            
        }).buttonStyle(SweeneyButtonStyle())
    }
    
}

struct NextButton: View {
    
    @Binding var currentPage: Int
    @Binding var knowsPcName: Bool
    
    var body: some View {
        
        Button("Next", action: {
            if currentPage == 3 && knowsPcName {
                currentPage = 5
            } else if currentPage < 5 {
                currentPage += 1
            } else {
                currentPage = 0
            }
            
        }).buttonStyle(SweeneyButtonStyle())
    }
    
}

struct EnterCodeButton: View {
    @EnvironmentObject var user: MockUser
    
    @Binding var currentPage: Int
    @Binding var knowsPcName: Bool
    @Binding var codeInput: Int?
    @Binding var showErrorText: Bool
    
    var body: some View {
        
        Button("Enter", action: {
            if user.loginCode != codeInput {
                showErrorText = true
            } else {
                currentPage += 1
                user.hasLoginCode = true
            }
            
        }).buttonStyle(SweeneyButtonStyle())
    }
    
}

struct SubmitInfoButton: View {
    
    @Binding var currentPage: Int
    @Binding var knowsPcName: Bool
    @EnvironmentObject var user: MockUser
    
    var body: some View {
        
        Button("Submit", action: {
            currentPage += 1
            Task {
                print("\(Access().accessToken)")
            }
        }).buttonStyle(SweeneyButtonStyle())
    }
    
}

struct SendTicketButton: View {
    
    @Binding var currentPage: Int
    @Binding var knowsPcName: Bool
    @EnvironmentObject var user: MockUser
    
    var body: some View {
        
        Button("Send", action: {
            
        }).buttonStyle(SweeneyButtonStyle())
    }
    
}
