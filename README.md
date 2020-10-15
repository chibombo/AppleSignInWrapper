[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=chibombo_AppleIDButtonWrapper&metric=alert_status)](https://sonarcloud.io/dashboard?id=chibombo_AppleIDButtonWrapper)

# AppleSignInWrapper
An easy way to implement Apple Sign In

## Content
1. [Features](#features)
2. [Requirements](#requirements)
3. [Installation](#installation)
   * [CocoaPods](#cocoapods)
   * [Swift Package Manager](#swift-package-manager)
4. [UIKit Example](#uikit-example)
5. [SwiftUI Example](#swiftui-example)
6. [Notes](#notes)


## Features
* Apple Sign in Button in SwiftUI!
* Apple Sign In Button in Storyboard!
    * States
    * Colors
    * Width
* A wrapper for the Apple Sign In Fuctions

## Requirements

* iOS 9+ (Classes and Protocols available in iOS 13)
* Swift 4+
* SetUp Capabilities of the Project

## Installation
### CocoaPods
Just add the next line in your podfile
```
pod 'AppleSignInWrapper'
```
### Swift Package Manager
Just add the next URL in the Swift Package of your project and set the last version

```
https://github.com/chibombo/AppleSignInWrapper
```

## UIKit Example

* How to check **state** of the session if exist. **KeychainItem** is used to get and set appleId in Keychain(Not included in the wrapper)

```
import UIKit
import AuthenticationServices
import AppleSignInWrapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        if #available(iOS 13.0, *) {
            AppleSignInWrapper().checkUserState(userID: KeychainItem.currentUserIdentifier) { (state: ASAuthorizationAppleIDProvider.CredentialState?, error:Error?) in
                if let anError: Error = error{                    
                    // Here you should call your Login ViewController
                } else if let aState: ASAuthorizationAppleIDProvider.CredentialState = state{
                    switch aState {
                    case .authorized:
                        DispatchQueue.main.async {
                            // Here you should call your backend to create a session
                        }
                    case .notFound, .revoked:
                        DispatchQueue.main.async {
                            // Here you should call your Login ViewController 
                        }
                    default:
                        // Here you should call your Login ViewController
                    }
                } else {
                    // Here you should call your Login ViewController
                }
            }
        } else {
            // Fallback on earlier versions
            // Here you should call your Login ViewController without Apple Sign In Button
        }
        return true
    }
```

* How to implement Apple Sign In with the Wrapper

```
import UIKit
import AuthenticationServices
import AppleSignInWrapper

@available(iOS 13.0, *)
class ViewController: AppleIDLoginDelegate {
    // MARK: - Outlets

    @IBOutlet weak var btnAppleSignIn: AppleIDButtonWrapper!
    
    var appleWrapper: AppleSignInWrapper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAppleSignIn.addTarget(self,
                                 action: #selector(userTappedSignInWithApple),
                                 for: .touchUpInside)
        appleWrapper = AppleSignInWrapper(view: self.view)
        appleWrapper.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @objc func userTappedSignInWithApple() {
        appleWrapper.requestSignIn()
    }
    
    func appleSignInWrapper(didComplete withError: Error) {

    }
    
    func appleSignInWrapper(didComplete withUser: UserInformation) {
        // Here you should save your user identifier and backend stuff
         
    }
}
```

* How to use AppleSignInButton in Storyboards
   * Create an UIButton in your Storyboard
   * Set **AppleIDButtonWrapper** as Custom Class of the button.
   * ![How to set AppleIDButtonWrapper](https://github.com/chibombo/AppleIDButtonWrapper/blob/source/Resources/Setup1.png "How to set AppleIDButtonWrapper")   
   * Enjoy and custom your button
   * ![How to set AppleIDButtonWrapper](https://github.com/chibombo/AppleIDButtonWrapper/blob/source/Resources/setup2.png "How to set AppleIDButtonWrapper")  
   * ![How to set AppleIDButtonWrapper](https://github.com/chibombo/AppleIDButtonWrapper/blob/source/Resources/Example2.png "How to set AppleIDButtonWrapper")  
   * ![How to set AppleIDButtonWrapper](https://github.com/chibombo/AppleIDButtonWrapper/blob/source/Resources/Example1.png "How to set AppleIDButtonWrapper") 
   * **If you use Constraints, please read the Apple Guidelines to avoid warnings in your constraints and the button appear correctly in your view.**

## SwiftUI Example

* Create an **UIViewRepresentable** to use **AppleIDButtonWrapper**
```
import SwiftUI
import AppleSignInWrapper

struct AppleSignInButton: UIViewRepresentable {
    
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var userIdentifier: String
    @Binding var email: String?
    
    typealias UIViewType = AppleIDButtonWrapper
    
    func makeCoordinator() -> AppleSignInCoordinator {
        return AppleSignInCoordinator(loginView: self)
    }

    func makeUIView(context: UIViewRepresentableContext<AppleSignInButton>) -> AppleIDButtonWrapper {
        let appleSignInButton = AppleIDButtonWrapper()
        appleSignInButton.authButtonType = 1
        appleSignInButton.authButtonStyle = 2
        appleSignInButton.layer.cornerRadius = 0
        appleSignInButton.addTarget(context.coordinator, action: #selector(context.coordinator.userTappedAppleSignIn), for: .touchUpInside)
        return appleSignInButton
    }

    func updateUIView(_ uiView: AppleIDButtonWrapper, context: UIViewRepresentableContext<AppleSignInButton>) {
    }
}
```
* Create a **coordinator** in order to manage delegate methods of our wrapper.

```
import SwiftUI
import AuthenticationServices
import AppleSignInWrapper

class AppleSignInCoordinator: NSObject {
    
    var appleWrapper: AppleSignInWrapper!
    var loginView: AppleSignInButton?

    override init() {
        super.init()
        appleWrapper = AppleSignInWrapper()
        appleWrapper.delegate = self
    }

    init(loginView: AppleSignInButton) {
        super.init()
        self.loginView = loginView
        appleWrapper = AppleSignInWrapper()
        appleWrapper.delegate = self
    }

    @objc func userTappedAppleSignIn() {
        appleWrapper.view = UIApplication.shared.windows.last!.rootViewController?.view
        appleWrapper.requestSignIn()
    }
}

extension AppleSignInCoordinator: AppleIDLoginDelegate {
    func appleSignInWrapper(didComplete withError: Error) {
        
    }
    
    func appleSignInWrapper(didComplete withUser: UserInformation, nonce: String?) {
        loginView?.email = withUser.email
        loginView?.firstName = withUser.firstName
        loginView?.lastName = withUser.lastName
        loginView?.userIdentifier = withUser.userIdentifier       
    }  
}
```
* Use your **AppleSignInButton**
```
import SwiftUI

struct ContentView: View {
    var body: some View {
        AppleSignInButton(firstName: .constant(""),
                          lastName: .constant(""),
                          userIdentifier: .constant(""),
                          email: .constant(""))
            .frame(width: 200, height: 40, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

## Notes
* Visit this Git https://github.com/LeeKahSeng/SwiftSenpai-ASAuthorizationAppleIDButton-Storyboard

* Apple Guidelines https://developer.apple.com/sign-in-with-apple/get-started/
