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
    
    
    // Remove photo to firebase favourites
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
    
    // Get photo to firebase
    func fetchPhotosToFirebaseFirestore(collectionName: String, completion: @escaping ([Photo]) -> Void) {
        guard let user = FireBaseAuthAccessible.shared.user else {return}
        db.collection("\(user.uid)+"+collectionName).getDocuments() { (querySnapshot, err) in
            var photos:[Photo] = []
            if let err = err {
                print("Error getting documents: \(err)")
                completion([])
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let id = data["id"] as! String?
                    let photo:Photo = Photo(id: data["id"] as! String?,
                                      owner: data["owner"] as! String?,
                                      secret: data["secret"] as! String?,
                                      server: data["server"] as! String?,
                                      farm: data["farm"] as! Int?,
                                      title: data["title"] as! String?,
                                      datetaken: data["datetaken"] as! String?,
                                      ownername: data["ownername"] as! String?,
                                      url_n: data["url_n"] as! String?)
                    photos.append(photo)
                }
                completion(photos)
            }
        }
        completion([])
    }
}
