//
//  ProfileViewModel.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 18.10.2022.
//

import Foundation

final class ProfileViewModel{
    var photosArray: [Photo] = []{
        didSet{
            self.changeHandler?(.didFetchPhotos)
        }
    }
    
    var numberOfRows: Int{
        photosArray.count
    }
    
    var changeHandler: ((RecentPhotoListChanges) -> Void)?
    
    
    func fetchSavedPhotos() {
        FirebaseFirestoreManagement.shared.fetchPhotosToFirebaseFirestore(collectionName: "_s") { photos in
            self.photosArray = photos
        }
    }
    
    func fetchFavouritePhotos() {
        FirebaseFirestoreManagement.shared.fetchPhotosToFirebaseFirestore(collectionName: "_f"){ photos in
            self.photosArray = photos
        }
    }
    
    func photoForIndexPath(_ indexPath: IndexPath) -> Photo? {
        photosArray[indexPath.row]
    }
}
