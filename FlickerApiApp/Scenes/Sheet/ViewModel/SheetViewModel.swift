//
//  SheetViewModel.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 19.10.2022.
//

import Foundation

final class SheetViewModel{
    // Add photo to firebase favourites
    func addPhotoToFirebaseFirestoreAsFavourite(_ photo: Photo?) {
        FirebaseFirestoreManagement.shared.addPhotoToFirebaseFirestoreAsFavourite(photo)
    }
    
    // Remove photo from firebase favourites
    func removePhotoToFirebaseFirestoreFromFavorite(_ photo: Photo?) {
        FirebaseFirestoreManagement.shared.removePhotoToFirebaseFirestoreFromFavorite(photo)
    }

    // Add photo to firebase saved
    func addPhotoToFirebaseFirestoreAsSaved(_ photo: Photo?) {
        FirebaseFirestoreManagement.shared.addPhotoToFirebaseFirestoreAsSaved(photo)
    }
    
    // Remove photo from firebase saved
    func removePhotoToFirebaseFirestoreFromSaved(_ photo: Photo?) {
        FirebaseFirestoreManagement.shared.removePhotoToFirebaseFirestoreFromSaved(photo)
    }
}
