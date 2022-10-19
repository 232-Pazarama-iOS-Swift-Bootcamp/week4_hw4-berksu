//
//  FirebaseAuthAccessible.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 17.10.2022.
//

import Foundation
import FirebaseAuth

struct FireBaseAuthAccessible {
    static var shared = FireBaseAuthAccessible()
    
    let auth: Auth
    
    private init(){
        auth =  Auth.auth()
    }
    
    var user: User? {
        auth.currentUser
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
        } catch {
            print("error signOut: \(error.localizedDescription)")
        }
    }
}

