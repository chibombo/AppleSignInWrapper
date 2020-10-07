//
//  AppleIDLoginDelegateSpy.swift
//  AppleIDButtonWrapper
//
//  Created by Genaro Arvizu on 05/10/20.
//  Copyright © 2020 Luis Genaro Arvizu Vega. All rights reserved.
//

import Foundation
@testable import AppleIDButtonWrapper
class AppleIDLoginDelegateSpy: AppleIDLoginDelegate {
       
    var isSignIn: Bool = false
    
    var user: UserInformation!
    var error: Error = NSError()
    
    func appleSignInWrapper(didComplete withError: Error) {
        isSignIn = false
        user = nil
        error = withError
    }
    
    func appleSignInWrapper(didComplete withUser: UserInformation, nonce: String?) {
        isSignIn = true
        user = withUser
    }
}
