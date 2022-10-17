//
//  MainViewController.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 13.10.2022.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {

    let mainViewModel = MainViewViewModel()
    let mainView = MainView()
    
    var isFavouriteButtonTouched = false
    var isSaveButtonTouched = false

    // MARK: - Lifecycle
    override func viewDidLoad() {
        mainViewModel.fetchRecentPhotos()
        super.viewDidLoad()
        view = mainView
        initTableView()
        
        mainViewModel.changeHandler = { change in
            switch change{
            case .didFetchPhotos:
                self.mainView.tableView.reloadData()
            case .didErrorOccurred(let error):
                print(error.localizedDescription)
            }
        }
    }

    
    // MARK: -TableView init
    func initTableView(){
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
}

// MARK: - TableView Delegate
extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Index: \(indexPath.row)")
    }
}


// MARK: - TableView DataSource
extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainViewModel.numberOfRows
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCustomCell.identifier, for: indexPath) as? MainViewCustomCell else{
            return UITableViewCell()
        }
        
        guard let photoAtIndex = mainViewModel.photoForIndexPath(indexPath) else {fatalError("Photo is nil")}
        
        let url = photoAtIndex.url_n ?? ""
        if let farm = photoAtIndex.farm,
           let server = photoAtIndex.server,
           let owner = photoAtIndex.owner
        {
            let profileImageURL = "https://farm\(farm).staticflickr.com/\(server)/buddyicons/\(owner).jpg"
            KingfisherOperations.shared.downloadProfileImage(url: profileImageURL, imageView: cell.profileImageView){success in
                if(success){
                    cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.width / 2
                    cell.profileImageView.clipsToBounds = true
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
            
        }
        
 
        KingfisherOperations.shared.downloadImage(url: url, imageView: cell.photoImageView){success in
            if success{
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        cell.title = photoAtIndex.ownername
        cell.addFavouriteButton.photo = photoAtIndex
        cell.addFavouriteButton.cell = cell
        cell.addFavouriteButton.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
        
        cell.saveButton.photo = photoAtIndex
        cell.saveButton.cell = cell
        cell.saveButton.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
        return cell
    }
}


// MARK: User Intents
extension MainViewController{
    @objc func addToFavourite(sender:SubclassedUIButton){
        guard let isTouched = sender.cell?.isFavuriteButtonTouched else{return}
        if !isTouched{
            mainViewModel.addPhotoToFirebaseFirestoreAsFavourite(sender.photo)
            sender.cell?.isFavuriteButtonTouched = true
        }else{
            mainViewModel.removePhotoToFirebaseFirestoreFromFavorite(sender.photo)
            sender.cell?.isFavuriteButtonTouched = false
        }
    }
    
    @objc func saveButton(sender:SubclassedUIButton){
        guard let isTouched = sender.cell?.isSaveButtonTouched else{return}
        if !isTouched{
            mainViewModel.addPhotoToFirebaseFirestoreAsSaved(sender.photo)
            sender.cell?.isSaveButtonTouched = true
        }else{
            mainViewModel.removePhotoToFirebaseFirestoreFromSaved(sender.photo)
            sender.cell?.isSaveButtonTouched = false
        }
    }
}


class SubclassedUIButton: UIButton {
    var photo: Photo?
    var cell: MainViewCustomCell?
}
