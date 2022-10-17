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


// MARK: -TableView Delegate
extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Index: \(indexPath.row)")
    }
}


// MARK: -TableView DataSource
extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainViewModel.numberOfRows
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCustomCell.identifier, for: indexPath) as? MainViewCustomCell else{
            return UITableViewCell()
        }
        
        let photoAtIndex = mainViewModel.photoForIndexPath(indexPath)
        
        let url = photoAtIndex?.url_n ?? ""
        if let farm = photoAtIndex?.farm,
           let server = photoAtIndex?.server,
           let owner = photoAtIndex?.owner
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
        cell.title = photoAtIndex?.ownername

        return cell
    }
    
    
    
}
