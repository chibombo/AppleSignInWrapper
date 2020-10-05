//
//  AppleIDLoginDelegate.swift
//  AppleIDButtonWrapper
//
//  Created by Luis Genaro Arvizu Vega on 05/04/20.
//  Copyright © 2020 Luis Genaro Arvizu Vega. All rights reserved.
//

import Foundation
import AuthenticationServices

public protocol AppleIDLoginDelegate: class {

    /// This method is called when an Error occurs
    /// - Parameter with: Error from Apple Sign In proccess
    func appleSignInWrapper(didComplete withError: Error)
    /// This method is called when the Sign In was success
    /// - Parameter with: First name, last name,  id, optional token, optional email
    func appleSignInWrapper(didComplete withUser: UserInformation)
}
