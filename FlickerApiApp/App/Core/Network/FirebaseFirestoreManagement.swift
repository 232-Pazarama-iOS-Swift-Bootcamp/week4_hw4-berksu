//
//  FirebaseFirestore.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 17.10.2022.
//

import Foundation
import FirebaseFirestore

struct FirebaseFirestoreManagement{
    
    static var shared = FirebaseFirestoreManagement()
    
    private let db = Firestore.firestore()
    private init(){}
    
    // Add photo to firebase favourites
    func addPhotoToFirebaseFirestoreAsFavourite(_ photo: Photo?) {
        guard let photo = photo else { return }
        guard let id = photo.id else { return }

        let photo_dict:[String : Any] = ["id": id,
                          "owner": photo.owner!,
                          "secret": photo.secret!,
                          "server": photo.server!,
                          "farm": photo.farm!,
                          "title": photo.title!,
                          "datetaken": photo.datetaken!,
                          "ownername": photo.ownername!,
                          "url_n": photo.url_n!
        ]
        
        guard let user = FireBaseAuthAccessible.shared.user else {return}
        
        db.collection("\(user.uid)+_f").document(id).setData(photo_dict) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    
    // Add photo to firebase favourites
    func removePhotoToFirebaseFirestoreFromFavorite(_ photo: Photo?) {
        guard let photo = photo else { return }
        guard let id = photo.id else { return }
        guard let user = FireBaseAuthAccessible.shared.user else {return}
        
        db.collection("\(user.uid)+_f").document(id).delete() { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully deleted!")
            }
        }
        
    }
    
    // Add photo to firebase favourites
    func addPhotoToFirebaseFirestoreAsSaved(_ photo: Photo?) {
        guard let photo = photo else { return }
        guard let id = photo.id else { return }

        let photo_dict:[String : Any] = ["id": id,
                          "owner": photo.owner!,
                          "secret": photo.secret!,
                          "server": photo.server!,
                          "farm": photo.farm!,
                          "title": photo.title!,
                          "datetaken": photo.datetaken!,
                          "ownername": photo.ownername!,
                          "url_n": photo.url_n!
        ]
        
        guard let user = FireBaseAuthAccessible.shared.user else {return}
        
        db.collection("\(user.uid)+_s").document(id).setData(photo_dict) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    
    // Add photo to firebase favourites
    func removePhotoToFirebaseFirestoreFromSaved(_ photo: Photo?) {
        guard let photo = photo else { return }
        guard let id = photo.id else { return }
        guard let user = FireBaseAuthAccessible.shared.user else {return}
        
        db.collection("\(user.uid)+_s").document(id).delete() { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully deleted!")
            }
        }
        
    }
}
