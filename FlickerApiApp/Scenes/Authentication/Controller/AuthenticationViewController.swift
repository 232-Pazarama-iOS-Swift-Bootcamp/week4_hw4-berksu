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
    let auth = Auth.auth()
    var signedIn = false
    
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String?, password: String?){
        guard let email = email, let password = password else{
            print("email or password is empty")
            return
        }

        auth.signIn(withEmail: email,
                    password: password){ [weak self] result, error in
            
            if let error = error as? NSError{
                print("Error: \(error.localizedDescription)")
                return
            }else{
                print("Sign In")
            }
            
            guard result != nil, error == nil else{ return }
            
            
            // Success
            DispatchQueue.main.async {
                self?.signedIn = true
            }

            let mainViewController = MainViewController()
            self?.navigationController?.pushViewController(mainViewController, animated: true)
        }
    }
    
    func signUp(email: String?, password: String?){
        guard let email = email, let password = password else{
            print("email or password is empty")
            return
        }
        if email.isValidEmail && password.isValidPassword{
            auth.createUser(withEmail: email,
                            password: password){ [weak self] result, error in
                
                if let error = error as? NSError{
                    print("Error: \(error.localizedDescription)")
                    return
                }else{
                    print("Sign Up")
                }
                
                guard result != nil, error == nil else{ return }
                
                // Success
                DispatchQueue.main.async {
                    self?.signedIn = true
                }
                
                let tabBarViewController = TabBarViewController()
                self?.navigationController?.pushViewController(tabBarViewController, animated: true)
            }
        }else{
            print("\(password.getMissingValidation())")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //try! Auth.auth().signOut()
        view.backgroundColor = .red
        if !isSignedIn{
            view = authenticationView
        }else{
            let tabBarViewController = TabBarViewController()
            self.navigationController?.pushViewController(tabBarViewController, animated: true)
        }
        authenticationView.signInSignUpButton.addTarget(self, action: #selector(signInSignUpButtonAction), for: .touchUpInside)
    }
    
    // - MARK: Button Methods
    @objc func signInSignUpButtonAction(sender: UIButton!) {
        if authenticationView.segmentedControl.selectedSegmentIndex == 0{
            signIn(email: authenticationView.mailAddress, password: authenticationView.password)
        }else{
            signUp(email: authenticationView.mailAddress, password: authenticationView.password)
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

