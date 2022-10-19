//
//  SheetViewController.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 18.10.2022.
//

import UIKit

final class SheetViewController: UIViewController{
    
    let sheetView = SheetView()
    let sheetViewModel = SheetViewModel()
    
    var photo: Photo?
    var userFavourites: [Photo] = []
    var userSaved: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let photo = photo else {return}
        updateUsersChoices(photo)
        view = sheetView
        
                
        KingfisherOperations.shared.downloadImage(url: photo.url_n ?? "", imageView: sheetView.photoImageView){_ in
        }
        
        sheetView.addFavouriteButton.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
        sheetView.saveButton.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
    }
    
    
    @objc func addToFavourite(){
        guard let photo = photo else {return}
        if !sheetView.isFavuriteButtonTouched{
            sheetViewModel.addPhotoToFirebaseFirestoreAsFavourite(photo)
            sheetView.isFavuriteButtonTouched = true
        }else{
            sheetViewModel.removePhotoToFirebaseFirestoreFromFavorite(photo)
            sheetView.isFavuriteButtonTouched = false
        }
    }
    
    @objc func saveButton(){
        guard let photo = photo else {return}
        if !sheetView.isSaveButtonTouched{
            sheetViewModel.addPhotoToFirebaseFirestoreAsSaved(photo)
            sheetView.isSaveButtonTouched = true
        }else{
            sheetViewModel.removePhotoToFirebaseFirestoreFromSaved(photo)
            sheetView.isSaveButtonTouched = false
        }
    }

    
    func updateUsersChoices(_ photo: Photo){
        FirebaseFirestoreManagement.shared.fetchPhotosToFirebaseFirestore(collectionName: "_s") { photos in
            self.userSaved = photos
            if(self.userSaved.contains(where: { photoItem in photoItem.url_n == photo.url_n })){
                self.sheetView.isSaveButtonTouched = true
            }else{
                self.sheetView.isSaveButtonTouched = false
            }
        }
        
        FirebaseFirestoreManagement.shared.fetchPhotosToFirebaseFirestore(collectionName: "_f") { photos in
            self.userFavourites = photos
            if(self.userFavourites.contains(where: { photoItem in photoItem.url_n == photo.url_n })){
                self.sheetView.isFavuriteButtonTouched = true
            }else{
                self.sheetView.isFavuriteButtonTouched = false
            }
        }
    }

}
