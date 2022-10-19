//
//  AuthenticationViewController.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 12.10.2022.
//

import UIKit
import FirebaseAuth

class AuthenticationViewController: UIViewController {

    let authenticationView = AuthenticationView()
    let authenticationViewModel = AuthenticationViewModel()
    
    var signedIn = false
    var isSignedIn: Bool {
        return authenticationViewModel.isSignedIn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //try! Auth.auth().signOut()
        view.backgroundColor = .red
        signedIn = authenticationViewModel.signedIn
        if !isSignedIn{
            view = authenticationView
            authenticationViewModel.fetchRemoteConfig { isSignUpDisabled in
                self.authenticationView.segmentedControl.isHidden = isSignUpDisabled
            }
        }else{
            let tabBarViewController = TabBarViewController()
            self.navigationController?.pushViewController(tabBarViewController, animated: true)
        }
        authenticationView.signInSignUpButton.addTarget(self, action: #selector(signInSignUpButtonAction), for: .touchUpInside)
        
        authenticationViewModel.changeHandler = { change in
            switch change {
            case .didErrorOccurred(let error):
                //self.showError(error)
                print("\(error.localizedDescription)")
            case .didSignUpSuccessful:
                //self.showAlert(title: "SIGN UP SUCCESSFUL!")
                print("Sign Up Successfull")
                let tabBarViewController = TabBarViewController()
                self.navigationController?.pushViewController(tabBarViewController, animated: true)
            }
        }
    }
    
    // - MARK: Button Methods
    @objc func signInSignUpButtonAction(sender: UIButton!) {
        if authenticationView.segmentedControl.selectedSegmentIndex == 0{
            authenticationViewModel.signIn(email: authenticationView.mailAddress, password: authenticationView.password)
        }else{
            authenticationViewModel.signUp(email: authenticationView.mailAddress, password: authenticationView.password)
        }
    }
    
}


// Forget password
//Auth.auth().sendPasswordReset(withEmail: email) { error in
//  // [START_EXCLUDE]
//  strongSelf.hideSpinner {
//    if let error = error {
//      strongSelf.showMessagePrompt(error.localizedDescription)
//      return
//    }
//    strongSelf.showMessagePrompt("Sent")
//  }
//  // [END_EXCLUDE]
//}


// Set user password
//Auth.auth().currentUser?.updatePassword(to: password) { error in
//  // ...
//}

