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
    
    override func viewWillAppear(_ animated: Bool) {
        // If user already signed, directly go to tab bar
        if !isSignedIn{
            view = authenticationView
            authenticationViewModel.fetchRemoteConfig { isSignUpDisabled in
                self.authenticationView.segmentedControl.isHidden = isSignUpDisabled
            }
        }else{
            let tabBarViewController = TabBarViewController()
            tabBarViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(tabBarViewController, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        signedIn = authenticationViewModel.signedIn
        
        // User intent
        authenticationView.signInSignUpButton.addTarget(self, action: #selector(signInSignUpButtonAction), for: .touchUpInside)
        
        authenticationViewModel.changeHandler = {[weak self] change in
            switch change {
            case .didErrorOccurred(let error):
                print("\(error.localizedDescription)")
            case .didSignUpSuccessful:
                print("Sign Up Successfull")
                let tabBarViewController = TabBarViewController()
                tabBarViewController.modalPresentationStyle = .fullScreen
                self?.navigationController?.present(tabBarViewController, animated: true)
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


