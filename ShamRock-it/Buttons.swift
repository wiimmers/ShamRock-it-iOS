//
//  Buttons.swift
//  ShamRock-it
//
//  Created by Nicholas Wimmers on 3/10/24.
//

import SwiftUI

struct SubmitButton: View {
    
    @Binding var currentPage: Int
    @State var buttonText: String
    
    var body: some View {
        
        Button("\(buttonText)") {
            currentPage += 1
            
        }
            .frame(width: 130, height: 40)
            .background(Color("sweeneyGreen").gradient)
            .foregroundColor(Color("sweeneyYellow"))
            .cornerRadius(30)
            .font(.system(size: 20))
            .fontWeight(.bold)
            .padding(.top, 20)
    }
    
}

struct BackButton: View {
    
    @Binding var currentPage: Int
    
    var body: some View {
        
        let buttonText = "Back"
        
        Button("\(buttonText)") {
            currentPage -= 1
            
        }
            .frame(width: 130, height: 40)
            .background(Color("sweeneyGreen").gradient)
            .foregroundColor(Color("sweeneyYellow"))
            .cornerRadius(30)
            .font(.system(size: 20))
            .fontWeight(.bold)
            .padding(.top, 20)
    }
    
}
