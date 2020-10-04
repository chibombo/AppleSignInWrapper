//
//  AppleIDButtonWrapper.swift
//  AppleIDButtonWrapper
//
//  Created by Luis Genaro Arvizu Vega on 05/04/20.
//  Copyright © 2020 Luis Genaro Arvizu Vega. All rights reserved.
//  Base Project: https://github.com/LeeKahSeng/SwiftSenpai-ASAuthorizationAppleIDButton-Storyboard


import UIKit
import AuthenticationServices

@available(iOS 13.0, *)
@IBDesignable
public class AppleIDButtonWrapper: UIButton {

    @IBInspectable
    public var cornerRadius: CGFloat = 6.0
    
    @IBInspectable
    public var authButtonType: Int = ASAuthorizationAppleIDButton.ButtonType.default.rawValue
        
    @IBInspectable
    public var authButtonStyle: Int = ASAuthorizationAppleIDButton.Style.black.rawValue
    
    public var authorizationButton: ASAuthorizationAppleIDButton!        
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)

        // Create ASAuthorizationAppleIDButton
        let type = ASAuthorizationAppleIDButton.ButtonType.init(rawValue: authButtonType) ?? .default
        let style = ASAuthorizationAppleIDButton.Style.init(rawValue: authButtonStyle) ?? .black
        
        authorizationButton = ASAuthorizationAppleIDButton(authorizationButtonType: type,
                                                           authorizationButtonStyle: style)
        authorizationButton.cornerRadius = cornerRadius
        
        // Set selector for touch up inside event so that can forward the event to MyAuthorizationAppleIDButton
        authorizationButton.addTarget(self, action: #selector(authorizationAppleIDButtonTapped(_:)), for: .touchUpInside)
        // Show authorizationButton
        addSubview(authorizationButton)

        // Use auto layout to make authorizationButton follow the MyAuthorizationAppleIDButton's dimension
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorizationButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0),
            authorizationButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0),
            authorizationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0),
            authorizationButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0),
        ])
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
    }

    @objc func authorizationAppleIDButtonTapped(_ sender: Any) {
        // Forward the touch up inside event to MyAuthorizationAppleIDButton
        sendActions(for: .touchUpInside)
    }
    
}
