//
//  AppleSignInWrapperTests.swift
//  AppleIDButtonWrapperTests
//
//  Created by Genaro Arvizu on 05/10/20.
//  Copyright © 2020 Luis Genaro Arvizu Vega. All rights reserved.
//

import XCTest
import AuthenticationServices
@testable import AppleIDButtonWrapper
class AppleSignInWrapperTests: XCTestCase {

    var wrapper: AppleSignInWrapper!
    var spy: AppleIDLoginDelegateSpy!
    
    override func setUpWithError() throws {
        wrapper = AppleSignInWrapper()
        spy = AppleIDLoginDelegateSpy()
        wrapper.delegate = spy
    }

    override func tearDownWithError() throws {
        wrapper = nil
        spy = nil
    }

    func testDelegate_whenFail_signIn() throws {
        wrapper.view = UIView()
        let error: NSError = NSError(domain: "Local Error",
                                     code: 0,
                                     userInfo: [NSLocalizedDescriptionKey: "Local Error"])
        wrapper.delegate?.appleSignInWrapper(didComplete: error)
        
        XCTAssert(spy.error.localizedDescription == error.localizedDescription, "Different Error")
    }
    
    func testDelegate_WhenUser_SignIn() throws {
        wrapper = AppleSignInWrapper(view: UIView())
        wrapper.delegate = spy
        let identifier: String = UUID().uuidString
        let firstName: String = "Fulano"
        let lastName: String = "Perengano"
        let email: String = "your@email.com"
        let token: String = "Token"
        
        let model: UserInformation = UserInformation(userIdentifier: identifier,
                                                     firstName: firstName,
                                                     lastName: lastName,
                                                     email: email,
                                                     token: token)
        
        wrapper.delegate?.appleSignInWrapper(didComplete: model, nonce: nil)
        
        XCTAssert(spy.user.userIdentifier == model.userIdentifier, "Different User")
    }

    func testDelegate_WhenUserUseNonce_SignIn() throws {
        wrapper = AppleSignInWrapper(view: UIView())
        wrapper.delegate = spy
        let identifier: String = UUID().uuidString
        let firstName: String = "Fulano"
        let lastName: String = "Perengano"
        let email: String = "your@email.com"
        let token: String = "Token"
        
        let model: UserInformation = UserInformation(userIdentifier: identifier,
                                                     firstName: firstName,
                                                     lastName: lastName,
                                                     email: email,
                                                     token: token)
        
        wrapper.delegate?.appleSignInWrapper(didComplete: model, nonce: "MyNonce")
        
        XCTAssert(spy.user.userIdentifier == model.userIdentifier, "Different User")
    }
    
}
