//
//  Form.swift
//  ShamRock-it
//
//  Created by Nicholas Wimmers on 3/10/24.
//

import SwiftUI

struct TicketForm: View {
    
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    @Binding var ext: String
    
    var body: some View {
        
        HStack {
            Labels(label: "First Name")
            StringFields(input: $firstName, isRequired: true)
        }
        
        HStack {
            Labels(label: "Last Name")
            StringFields(input: $lastName, isRequired: true)
        }
        
        HStack {
            Labels(label: "Email")
            StringFields(input: $email, isRequired: true)
        }
        
        HStack {
            Labels(label: "Extension")
            StringFields(input: $ext, isRequired: false)
        }
    }
}

struct Labels: View {
    
    var label: String
    
    var body: some View {
        
            Text("\(label)")
                .frame(width: 100)
                .foregroundColor(Color("sweeneyYellow"))
                .font(.system(size:18))
                .fontWeight(.heavy)
                .padding(.leading, 10)
                
    }
}

struct StringFields: View {
    
    @Binding var input: String
    var isRequired: Bool
    

    var body: some View {
            TextField(isRequired ? "Required" : "", text: $input)
                .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.trailing)
                .textInputAutocapitalization(.never)
    }
}

struct IntFields: View {
    
    @Binding var input: Int?
    var isRequired: Bool
    

    var body: some View {
            TextField(isRequired ? "Required" : "", text: Binding<String>(
                get: { self.input.map(String.init) ?? "" },
                set: {
                    // Convert the entered text back to an Int
                    self.input = Int($0)
                }
            ))
                .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.trailing)
                .textInputAutocapitalization(.never)
    }
}
