//
//  AppleIDButtonWrapperTests.swift
//  AppleIDButtonWrapperTests
//
//  Created by Luis Genaro Arvizu Vega on 05/04/20.
//  Copyright © 2020 Luis Genaro Arvizu Vega. All rights reserved.
//

import XCTest
import AuthenticationServices
@testable import AppleIDButtonWrapper

class AppleIDButtonWrapperTests: XCTestCase {

    var wrapper: AppleIDButtonWrapper!
        
    override func setUpWithError() throws {
        wrapper = AppleIDButtonWrapper()
        wrapper.draw(.zero)
    }

    override func tearDownWithError() throws {
        wrapper = nil
    }

    func testButtonDefaultType_whenUser_useDefaultValues() throws {
        let defaultType: ASAuthorizationAppleIDButton.ButtonType = ASAuthorizationAppleIDButton.ButtonType.default
        
        XCTAssert(wrapper.authButtonType == defaultType.rawValue)

    }

    func testButtonDefaultStyle_whenUser_useDefaultValues() throws {
        let defaultStyle: ASAuthorizationAppleIDButton.Style = .black
        
        XCTAssert(wrapper.authButtonStyle == defaultStyle.rawValue)
    }

}
