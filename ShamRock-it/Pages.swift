//
//  Pages.swift
//  ShamRock-it
//
//  Created by Nicholas Wimmers on 3/10/24.
//

import SwiftUI

struct PageOne: View {
    @Binding var email: String
    @Binding var knowsPcName: Bool
    @Binding var currentPage: Int
    
    @State var showErrorText: Bool = false
    
    var body: some View {
        
        HeaderText(text: "Enter Email to get a login code")
        StringFields(input: $email,
                     isRequired: true)
        .padding(.leading)
        
        if showErrorText {
            Text("Must be an '@jakesweeney.com' email")
                .foregroundStyle(Color.white)
                .padding(.top, 5)
                .fontWeight(.ultraLight)
        }
        
        HStack {
            SendCodeButton(currentPage: $currentPage,
                           knowsPcName: $knowsPcName,
                           showErrorText: $showErrorText)
                .padding(10)
        }
    }
}

struct PageTwo: View {
    @Binding var loginCode: Int
    @Binding var knowsPcName: Bool
    @Binding var currentPage: Int
    
    @State var codeInput: Int? = nil
    @State var showErrorText: Bool = false
    
    var body: some View {
        
        HStack {
            Labels(label: "Login Code")
            IntFields(input: $codeInput,
                      isRequired: true)
            .padding(.leading)
        }
        
        if showErrorText {
            Text("Invalid Login Code")
                .foregroundStyle(Color.white)
                .padding(.vertical, 5)
                .fontWeight(.ultraLight)
        }
        
        HStack {
            Spacer()
            
            BackButton(currentPage: $currentPage,
                       knowsPcName: $knowsPcName)
            
            Spacer()
            
            EnterCodeButton(currentPage: $currentPage,
                            knowsPcName: $knowsPcName,
                            codeInput: $codeInput,
                            showErrorText: $showErrorText)
            
            Spacer()
        }
    }
}

struct PageThree: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    @Binding var ext: String
    
    @Binding var currentPage: Int
    @Binding var knowsPcName: Bool
    
    var body: some View {
        
        TicketForm(firstName: $firstName,
                   lastName: $lastName,
                   email: $email,
                   ext: $ext)
        
        HStack {
            SubmitInfoButton(currentPage: $currentPage,
                             knowsPcName: $knowsPcName)
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
                
            if (knowsPcName) {
                HStack {
                    Labels(label: "PC Name")
                    StringFields(input: $pcName, 
                           isRequired: true
                           )
                }.padding(.horizontal)
            } else {
                HStack {
                    Labels(label: "PC Name")
                    StringFields(input: $pcName, 
                           isRequired: true
                           )
                        .overlay(Color.gray)
                        .disabled(true)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding(.trailing)
                }.padding(.horizontal)
            }
                
            HStack {
                Spacer()
                
                BackButton(currentPage: $currentPage,
                           knowsPcName: $knowsPcName)
                    .padding(10)
                
                Spacer()
                
                NextButton(currentPage: $currentPage,
                           knowsPcName: $knowsPcName)
                    .padding(10)
                
                Spacer()
            }
        }
    }
}

struct PageFive: View {
    @Binding var currentPage: Int
    @Binding var knowsPcName: Bool
    @Binding var pcName: String
    
    var body: some View {
        
        VStack {
            HStack {
                HeaderText(text: "Enter Service Tag")
                Image(systemName: "info.circle")
                    .font(.system(size: 25))
                    .foregroundColor(Color("sweeneyYellow"))
                    .onTapGesture {
                        currentPage = 6
                    }
            }
            StringFields(input: $pcName,
                   isRequired: true)
            .padding(.leading)
            
            HStack{
                Spacer()
                
                BackButton(currentPage: $currentPage,
                           knowsPcName: $knowsPcName)
                    .padding(10)
                
                Spacer()
                
                NextButton(currentPage: $currentPage,
                             knowsPcName: $knowsPcName)
                    .padding(10)
                
                Spacer()
            }
        }
        
    }
}

struct PageSix: View {
    @Binding var currentPage: Int
    @Binding var knowsPcName: Bool
    @Binding var input: String
    
    var body: some View {
        
        VStack {
            HeaderText(text: "Enter your request")
            TextField("", text: $input, axis: .vertical)
                .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                .textInputAutocapitalization(.never)
            
            HStack {
                Spacer()
                
                BackButton(currentPage: $currentPage,
                           knowsPcName: $knowsPcName)
                    .padding(10)
                
                Spacer()
                
                SendTicketButton(currentPage: $currentPage,
                                 knowsPcName: $knowsPcName)
                    .padding(10)
                
                Spacer()
            }
        }
    }
}

struct ServiceTagHelpView: View {
    @Binding var currentPage: Int
    @State var isTapped: Bool = false
    @Binding var knowsPcName: Bool
    
    var body: some View {
        VStack{
            HeaderText(text: "Where to find your service tag")
            
            ZStack {
                Image("servicetag2")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .frame(width: isTapped ? 700 : 300, height: isTapped ? 600 : 300)
                    .onTapGesture {
                        withAnimation {
                            self.isTapped.toggle()
                        }
                    }
            }
            
            HStack {
                BackButton(currentPage: $currentPage,
                           knowsPcName: $knowsPcName)
            }
            
        }
    }
}

