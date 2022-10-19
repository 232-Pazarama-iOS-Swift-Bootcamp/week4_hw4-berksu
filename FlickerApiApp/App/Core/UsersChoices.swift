//
//  UsersChoices.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 19.10.2022.
//

import Foundation

class UsersChoices{
    static let shared = UsersChoices()
    
    var userFavourites: [Photo] = []
    var userSaved: [Photo] = []

    private init(){
        updateUsersChoices()
    }
    
    func updateUsersChoices(){
        FirebaseFirestoreManagement.shared.fetchPhotosToFirebaseFirestore(collectionName: "_s") { photos in
            self.userSaved = photos
        }
        
        FirebaseFirestoreManagement.shared.fetchPhotosToFirebaseFirestore(collectionName: "_f") { photos in
            self.userSaved = photos
        }
    }
    
}
