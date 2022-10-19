//
//  AuthenticationViewModel.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 19.10.2022.
//

import Foundation
import FirebaseAuth
import FirebaseRemoteConfig

enum AuthViewModelChange {
    case didErrorOccurred(_ error: Error)
    case didSignUpSuccessful
}

final class AuthenticationViewModel{
    
    let auth = Auth.auth()
    var signedIn = false
    var isSignedIn:Bool {
        return auth.currentUser != nil
    }
    
    var changeHandler: ((AuthViewModelChange) -> Void)?
    
    // Firebase Sign In
    func signIn(email: String?, password: String?){
        guard let email = email, let password = password else{
            print("email or password is empty")
            return
        }

        auth.signIn(withEmail: email,
                    password: password){ [weak self] result, error in
            
            if let error = error as? NSError{
                print("Error: \(error.localizedDescription)")
                self?.changeHandler?(.didErrorOccurred(error))
                return
            }else{
                print("Sign In")
                self?.changeHandler?(.didSignUpSuccessful)
            }
            
            guard result != nil, error == nil else{ return }
            
            
            // Success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    // Firebase Sign Up
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
                    self?.changeHandler?(.didErrorOccurred(error))
                    return
                }else{
                    print("Sign Up")
                    self?.changeHandler?(.didSignUpSuccessful)
                }
                
                guard result != nil, error == nil else{ return }
                
                // Success
                DispatchQueue.main.async {
                    self?.signedIn = true
                }
                
            }
        }else{
            print("\(password.getMissingValidation())")
        }
    }
    
    
    // Fetch remote config data from firebase
    func fetchRemoteConfig(completion: @escaping (Bool) -> Void) {
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        
        remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                remoteConfig.activate { _, error in
                    
                    if let error = error {
                        self.changeHandler?(.didErrorOccurred(error))
                        return
                    }
                    
                    let isSignUpDisabled = remoteConfig.configValue(forKey: "isSignUpDisabled").boolValue
                    DispatchQueue.main.async {
                        completion(isSignUpDisabled)
                    }
                }
            } else {
                guard let error = error else {
                    return
                }
                self.changeHandler?(.didErrorOccurred(error))
            }
        }
    }
}
