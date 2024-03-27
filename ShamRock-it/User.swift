//
//  User.swift
//  ShamRock-it
//
//  Created by Nicholas Wimmers on 3/12/24.
//

import Foundation
import SwiftUI

class User: ObservableObject {
    @Published var hasLoginCode: Bool {
        didSet {
            UserDefaults.standard.set(hasLoginCode, forKey: "hasLoginCode")
        }
    }
    @Published var knowsPcName: Bool = false
    
    @Published var email: String = ""
    @Published var ext: String = ""
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    
    @Published var pcName: String = ""
    @Published var loginCode: Int = 0
    
    @Published var userRequest: String = ""
    
    init() {
         // Load the value of hasLoginCode from UserDefaults, defaulting to false if not found
         self.hasLoginCode = UserDefaults.standard.bool(forKey: "hasLoginCode")
    }
}

class MockUser: ObservableObject {
    @Published var hasLoginCode: Bool = true
    @Published var knowsPcName: Bool = false
    
    @Published var email: String = ""
    @Published var ext: String = ""
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    
    @Published var pcName: String = ""
    @Published var loginCode: Int = 0
    
    @Published var userRequest: String = ""
    
}

struct RefreshResponse: Codable {
    var clientId: String
    var refreshToken: String
    
}

struct RefreshRequest: Codable {
    var grant_type: String
    var client_id: String
    var refresh_token: String
    
}

struct AuthResponse: Codable {
    var access_token: String = ""
    var refresh_token: String = ""
    var expires_in: UInt = 0
    var scope: String = ""
    var token_type: String = ""
}

class Access: ObservableObject {
    
    @Published var accessToken = ""
    
    init() {
        Task {
            let (id, token) = await getRefresh()
            let access = await getAccess(id, token)
            Task {
                DispatchQueue.main.async {
                    self.accessToken = access
                }
            }
        }
    }
    
    func getRefresh() async -> (String, String) {
        
        let url = URL(string: "https://shamrock-it-dev.dalewood.me/ios")!
        
        do {
            let (data, _): (Data, URLResponse) = try await URLSession.shared.data(from: url)
            let json = try JSONDecoder().decode(RefreshResponse.self, from: data)
            
            let (clientId, refreshToken) = (json.clientId, json.refreshToken)
            return (clientId, refreshToken)
        } catch {
            print("Data invalid format")
            return("", "")
        }
    }
    
    func getAccess(_ clientId: String, _ refreshToken: String) async -> String {
        guard var urlComponents = URLComponents(string: "https://jakesweeney.rmmservice.com/ws/oauth/token") else {
            print("Invalid URL")
            return ""
        }
        
        // Append query parameters
        urlComponents.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        
        // Create the URL
        guard let url = urlComponents.url else {
            print("Failed to create URL with query parameters")
            return ""
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON String:", jsonString)
            } else {
                print("Failed to convert data to JSON string.")
            }
            do {
                let json = try JSONDecoder().decode(AuthResponse.self, from: data)
                
                let accessToken = json.access_token
                
                return accessToken
            } catch {
                print("Fuck you")
                return ""
            }
        } catch {
            print("Error fetching access token")
            return ""
        }
    }
}
