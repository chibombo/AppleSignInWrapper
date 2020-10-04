//
//  UserInformation.swift
//  AppleIDButtonWrapper
//
//  Created by Luis Genaro Arvizu Vega on 05/04/20.
//  Copyright © 2020 Luis Genaro Arvizu Vega. All rights reserved.
//

import Foundation
import AuthenticationServices

public struct UserInformation {
    
    
    public let userIdentifier: String
    public let firstName: String
    public let lastName: String
    public let email: String?
    public let token: String?
    
    public init(userIdentifier: String, firstName: String, lastName: String, email: String?, token: String?) {
        self.userIdentifier = userIdentifier
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.token = token
    }
    
    public init(userIdentifier: String, firstName: String, lastName: String, email: String?, token: Data?) {
        self.userIdentifier = userIdentifier
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        if let tokenData: Data = token, let aToken: String = String(data:tokenData, encoding: .utf8) {
            self.token = aToken
        } else {
            self.token = nil
        }
    }
    
    @available(iOS 13.0, *)
    public init(_ appleIDCredential: ASAuthorizationAppleIDCredential) {
        self.userIdentifier = appleIDCredential.user
        self.firstName = appleIDCredential.fullName?.givenName ?? ""
        self.lastName = appleIDCredential.fullName?.familyName ?? ""
        self.email = appleIDCredential.email ?? ""
        if let tokenData: Data = appleIDCredential.identityToken,
            let aToken: String = String(data:tokenData, encoding: .utf8)  {
            self.token = aToken
            
        } else {
            self.token = nil
        }
    }
}
