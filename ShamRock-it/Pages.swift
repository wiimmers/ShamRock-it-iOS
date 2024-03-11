//
//  Pages.swift
//  ShamRock-it
//
//  Created by Nicholas Wimmers on 3/10/24.
//

import SwiftUI

struct PageOne: View {
    @Binding var email: String
    
    @Binding var currentPage: Int
    
    var body: some View {
        
        HeaderText(text: "Enter Email to get a login code")
        Fields(input: $email, isRequired: true).padding(.leading)
        
        HStack {
            SubmitButton(currentPage: $currentPage,
                         buttonText: "Send Code")
        }
        
    }
}

struct PageTwo: View {
    @Binding var loginCode: String
    
    @Binding var currentPage: Int
    
    var body: some View {
        
        HStack {
            Labels(label: "Login Code")
            Fields(input: $loginCode, isRequired: true).padding(.leading)
        }
        
        HStack {
            BackButton(currentPage: $currentPage)
                .padding(10)
            SubmitButton(currentPage: $currentPage,
                         buttonText: "Enter Code")
            .padding(10)
        }
    }
}

struct PageThree: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    @Binding var ext: String
    
    @Binding var currentPage: Int
    
    var body: some View {
        
        TicketForm(firstName: $firstName,
                   lastName: $lastName,
                   email: $email,
                   ext: $ext)
        
        HStack {
            BackButton(currentPage: $currentPage)
                .padding(10)
            SubmitButton(currentPage: $currentPage,
                         buttonText: "Submit Info")
            .padding(10)
        }
        
    }
}

struct PageFour: View {
    @Binding var knowsPcName: Bool
    @Binding var pcName: String
    
    @Binding var currentPage: Int
    
    var body: some View {
        VStack {
            Toggle("I know my PC Name", isOn: $knowsPcName)
                .toggleStyle(CheckmarkToggle())
                .foregroundStyle(Color("sweeneyYellow"))
                
            HStack {
                Labels(label: "PC Name")
                Fields(input: $pcName, isRequired: false).background(.gray)
            }.padding(.horizontal).disabled(true)
                
            if (knowsPcName) {
      
            }
                
            HStack {
                BackButton(currentPage: $currentPage)
                    .padding(10)
                SubmitButton(currentPage: $currentPage, buttonText: "Next")
                    .padding(10)
            }
        }
    }
}
