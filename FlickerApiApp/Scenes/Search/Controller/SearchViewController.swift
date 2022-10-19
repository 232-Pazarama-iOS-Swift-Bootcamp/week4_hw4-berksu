//
//  SearchViewController.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 16.10.2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
    let searchViewModel = SearchViewModel()
    let searchView = SearchView()
    
    override func viewDidLoad() {
        searchViewModel.fetchRecentPhotos()
        super.viewDidLoad()

        view = searchView
        setCollectionViewDelegate()
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Education, Fun..."
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        navigationItem.largeTitleDisplayMode = .never
        
        searchViewModel.changeHandler = { change in
            switch change{
            case .didFetchPhotos:
                self.searchView.collectionView.reloadData()
            case .didErrorOccurred(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - set delegates
    func setCollectionViewDelegate() {
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
    }
}

extension SearchViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index: \(indexPath.row)")
        // Create the view controller.
        guard let photoAtIndex = searchViewModel.photoForIndexPath(indexPath) else {fatalError("Photo is nil")}
        
        let sheetViewController = SheetViewController()
        sheetViewController.photo = photoAtIndex
        // Present it w/o any adjustments so it uses the default sheet presentation.
        present(sheetViewController, animated: true, completion: nil)
    }
}

extension SearchViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchViewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SearchViewCell else{
            return UICollectionViewCell()
        }
        
        print("\(indexPath.row)")
        let photoAtIndex = searchViewModel.photoForIndexPath(indexPath)
        
        let url = photoAtIndex?.url_n ?? ""
        KingfisherOperations.shared.downloadImage(url: url, imageView: cell.photoImageView){success in
            if success{
                collectionView.reloadItems(at: [indexPath])
            }
        }
        return cell
    }
}


// TODO: - Search will be added
extension SearchViewController: UISearchResultsUpdating{
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 1 {
            searchViewModel.fetchSearchedPhotos(text: text)
        }else{
            searchViewModel.fetchRecentPhotos()
        }
    }
}
