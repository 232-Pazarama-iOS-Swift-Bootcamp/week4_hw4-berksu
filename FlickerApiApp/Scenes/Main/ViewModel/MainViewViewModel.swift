//
//  MainViewViewModel.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 16.10.2022.
//

import Foundation

enum RecentPhotoListChanges {
    case didErrorOccurred(_ error: Error)
    case didFetchPhotos
}

final class MainViewViewModel{
 
    private var recentPhotosResponse: RecentPhotosResponse?{
        didSet{
            self.changeHandler?(.didFetchPhotos)
        }
    }
    
    var numberOfRows: Int{
        recentPhotosResponse?.photos?.photo?.count ?? .zero
    }
    
    var changeHandler: ((RecentPhotoListChanges) -> Void)?

    func fetchRecentPhotos() {
        provider.request(.getRecentImages(page: "1")) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.changeHandler?(.didErrorOccurred(error))
            case .success(let response):
                do {
                    let recentPhotosResponse = try JSONDecoder().decode(RecentPhotosResponse.self, from: response.data)
                    self?.recentPhotosResponse = recentPhotosResponse
                } catch {
                    self?.changeHandler?(.didErrorOccurred(error))
                }
            }
        }
    }
    
    func photoForIndexPath(_ indexPath: IndexPath) -> Photo? {
        recentPhotosResponse?.photos?.photo?[indexPath.row]
    }
    
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


