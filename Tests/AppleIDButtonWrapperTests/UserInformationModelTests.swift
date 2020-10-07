//
//  UserInformationModelTest.swift
//  AppleIDButtonWrapperTests
//
//  Created by Genaro Arvizu on 05/10/20.
//  Copyright © 2020 Luis Genaro Arvizu Vega. All rights reserved.
//

import XCTest
import AuthenticationServices
@testable import AppleSignInWrapper
class UserInformationModelTests: XCTestCase {

    var model: UserInformation!
    
    override func setUpWithError() throws {
        model = UserInformation(userIdentifier: "",
                                firstName: "",
                                lastName: "",
                                email: "",
                                token: "")
    }

    override func tearDownWithError() throws {
        model = nil
    }

    func testInitOneIntegrity() throws {
        let identifier: String = UUID().uuidString
        let firstName: String = "Fulano"
        let lastName: String = "Perengano"
        let email: String = "your@email.com"
        let token: String = "Token"
        
        model = UserInformation(userIdentifier: identifier,
                                firstName: firstName,
                                lastName: lastName,
                                email: email,
                                token: token)
        if model.userIdentifier == identifier,
           model.firstName == firstName,
           model.lastName == lastName,
           model.email == email,
           model.token == token {
            XCTAssert(true)
        } else {
            XCTAssert(false, "Integrity Problem")
        }
    }

    func testInitTwoIntegrity() throws {
        let identifier: String = UUID().uuidString
        let firstName: String = "Fulano"
        let lastName: String = "Perengano"
        let email: String = "your@email.com"
        let strToken: String = "Token"
        let token: Data? = strToken.data(using: .utf8)
        
        model = UserInformation(userIdentifier: identifier,
                                firstName: firstName,
                                lastName: lastName,
                                email: email,
                                token: token)
        if model.userIdentifier == identifier,
           model.firstName == firstName,
           model.lastName == lastName,
           model.email == email,
           model.token == strToken {
            XCTAssert(true)
        } else {
            XCTAssert(false, "Integrity Problem")
        }
    }
}
