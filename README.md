# AppleSignInWrapper

An easy way to implement Apple Sign In

## Features

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

```
pod 'AppleSignInWrapper'
```

## Example

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
   * Set **AppleIDButtonWrapper** as Custom Class of the button
   * ![How to set AppleIDButtonWrapper](https://github.com/chibombo/AppleIDButtonWrapper/blob/source/Resources/Setup1.png "How to set AppleIDButtonWrapper")   
   * Enjoy and custom your button
   * ![How to set AppleIDButtonWrapper](https://github.com/chibombo/AppleIDButtonWrapper/blob/source/Resources/setup2.png "How to set AppleIDButtonWrapper")  
   * ![How to set AppleIDButtonWrapper](https://github.com/chibombo/AppleIDButtonWrapper/blob/source/Resources/Example2.png "How to set AppleIDButtonWrapper")  
   * ![How to set AppleIDButtonWrapper](https://github.com/chibombo/AppleIDButtonWrapper/blob/source/Resources/Example1.png "How to set AppleIDButtonWrapper") 
   
## Notes
* Visit this Git https://github.com/LeeKahSeng/SwiftSenpai-ASAuthorizationAppleIDButton-Storyboard

* Apple Guidelines https://developer.apple.com/sign-in-with-apple/get-started/
