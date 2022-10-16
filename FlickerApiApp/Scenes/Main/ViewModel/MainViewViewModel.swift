//
//  MainViewViewModel.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 16.10.2022.
//

import Foundation
import Kingfisher

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
        provider.request(.getRecentImages(page: "1")) { result in
            switch result {
            case .failure(let error):
                print("error")
                self.changeHandler?(.didErrorOccurred(error))
            case .success(let response):
                do {
                    let recentPhotosResponse = try JSONDecoder().decode(RecentPhotosResponse.self, from: response.data)
                    self.recentPhotosResponse = recentPhotosResponse
                    print(recentPhotosResponse)
                } catch {
                    print("catched")
                    self.changeHandler?(.didErrorOccurred(error))
                }
            }
        }
    }
    
    func photoForIndexPath(_ indexPath: IndexPath) -> Photo? {
        recentPhotosResponse?.photos?.photo?[indexPath.row]
    }

}
