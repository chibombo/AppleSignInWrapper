//
//  AppleSignInWrapper.swift
//  AppleIDButtonWrapper
//
//  Created by Luis Genaro Arvizu Vega on 05/04/20.
//  Copyright © 2020 Luis Genaro Arvizu Vega. All rights reserved.
//

import UIKit
import CryptoKit
import AuthenticationServices

@available(iOS 13.0, *)
open class AppleSignInWrapper: NSObject {
    /// ViewController View
    public var view: UIView!
    public weak var delegate: AppleIDLoginDelegate?
    private var currentNonce: String?
    /// Constructor
    /// - Parameter view: ViewController View where Apple Sign In screen should be presented
    public init(view: UIView) {
        self.view = view
    }
    /// Don't forget set view
    public override init() {
    }

    /// Return the state of the User
    /// - Parameters:
    ///   - userID: User ID
    ///   - completionHandler: If the status is available return it, else return an error
    public func checkUserState(userID: String,
                               completionHandler: @escaping(ASAuthorizationAppleIDProvider.CredentialState?, Error?) -> Void) {
        ASAuthorizationAppleIDProvider().getCredentialState(forUserID: userID) { (credentialState: ASAuthorizationAppleIDProvider.CredentialState, error: Error?) in
            if let anError: Error = error {
                completionHandler(nil, anError)
            } else {
                completionHandler(credentialState, nil)
            }
        }
    }
    
    /// Request Sign In
    /// - Parameters:
    ///   - scopes: Array with default values, [.fullName, .email]
    ///   - nonce: Optional string, apple and some user managers use this nonce to validate the integrity of the auth, sha256.
    public func requestSignIn(scopes: [ASAuthorization.Scope] = [.fullName, .email], nonce: String? = nil) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = scopes
        currentNonce = nonce
        request.nonce = sha256(nonce)
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    @available(iOS 13, *)
    private func sha256(_ input: String?) -> String? {
        guard let input: String = input else {
            return nil
        }
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        return hashString
    }
    
}

@available(iOS 13.0, *)
extension AppleSignInWrapper: ASAuthorizationControllerDelegate {

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        if let appleIDCredential: ASAuthorizationAppleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let user: UserInformation = UserInformation(appleIDCredential)
            delegate?.appleSignInWrapper(didComplete: user, nonce: currentNonce)
        }
    }

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        delegate?.appleSignInWrapper(didComplete: error)
    }
}

@available(iOS 13.0, *)
extension AppleSignInWrapper: ASAuthorizationControllerPresentationContextProviding {

    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
