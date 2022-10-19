//
//  ProfileViewController.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 16.10.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    var profileView = ProfileView()
    var profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //view.backgroundColor = .blue
        view = profileView
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut))
        navigationItem.rightBarButtonItem?.tintColor = .red
        navigationItem.largeTitleDisplayMode = .never
        
        profileView.segmentedControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        
        profileView.name = "Berksu"
        
        setCollectionViewDelegate()
        
        profileViewModel.fetchFavouritePhotos()
        profileViewModel.changeHandler = { change in
            switch change{
            case .didFetchPhotos:
                self.profileView.collectionView.reloadData()
            case .didErrorOccurred(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(profileView.segmentedControl.selectedSegmentIndex == 0){
            profileViewModel.fetchFavouritePhotos()
        }else{
            profileViewModel.fetchSavedPhotos()
        }
        profileViewModel.changeHandler = { change in
            switch change{
            case .didFetchPhotos:
                self.profileView.collectionView.reloadData()
            case .didErrorOccurred(let error):
                print(error.localizedDescription)
            }
        }
    }
  
    
    @objc func signOut(){
        FireBaseAuthAccessible.shared.signOut()
        self.navigationController?.popToRootViewController(animated: true)
        print("Sign out")
    }
    
    @objc func segmentAction(_ segmentedControl: UISegmentedControl) {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            profileViewModel.fetchFavouritePhotos()
            profileView.collectionView.reloadData()
        case 1:
            profileViewModel.fetchSavedPhotos()
            profileView.collectionView.reloadData()
        default:
            break
        }
    }
    
    
    
    // MARK: - set delegates
    func setCollectionViewDelegate() {
        profileView.collectionView.delegate = self
        profileView.collectionView.dataSource = self
    }
}


extension ProfileViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index: \(indexPath.row)")
        // Create the view controller.
        guard let photoAtIndex = profileViewModel.photoForIndexPath(indexPath) else {fatalError("Photo is nil")}
        
        let sheetViewController = SheetViewController()
        sheetViewController.presentationController?.delegate = self
        sheetViewController.photo = photoAtIndex
        // Present it w/o any adjustments so it uses the default sheet presentation.
        present(sheetViewController, animated: true, completion: nil)
    }
}

extension ProfileViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileViewModel.photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProfileViewCell else{
            return UICollectionViewCell()
        }
        
        print("\(indexPath.row)")
        let photoAtIndex = profileViewModel.photoForIndexPath(indexPath)

        let url = photoAtIndex?.url_n ?? ""
        KingfisherOperations.shared.downloadImage(url: url, imageView: cell.photoImageView){success in
            if success{
                collectionView.reloadItems(at: [indexPath])
            }
        }
        
        return cell
    }
}
