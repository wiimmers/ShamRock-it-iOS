//
//  Mailer.swift
//  ShamRock-it
//
//  Created by Nicholas Wimmers on 3/11/24.
//

import Foundation
import SwiftSMTP
import SwiftUI

func codeMailer(recipient: String, loginCode: Binding<Int>) {
    let smtp = SMTP(hostname: "smtp.postoffice.net",
                    email: "maintenance@jakesweeney.com",
                    password: "Sh@mr0ck")
    
    let maintenance = Mail.User(email: "maintenance@jakesweeney.com")
    let user_email = Mail.User(email: recipient)
        
    let htmlAttachment = Attachment(htmlContent: codeMailFormatter(loginCode: loginCode))
        
    let mail = Mail(from: maintenance,
                    to: [user_email],
                    subject: "ShamRock-it Login Code",
                    attachments: [htmlAttachment])

    smtp.send(mail) { (error) in
        if let error = error {
            print(error)
        }
    }
}

private func codeMailFormatter(loginCode: Binding<Int>) -> String {
    
    let randomCode = Int.random(in: 10000..<100000)
    loginCode.wrappedValue = randomCode
    
    let greeting = "<h4>Thanks for using ShamRock-it for iPhone<h4>"

    let message = "<h5>Your login code is: \(randomCode)</h5>"

    
    return "<html>\(greeting)<br>\(message)</html>"
}

