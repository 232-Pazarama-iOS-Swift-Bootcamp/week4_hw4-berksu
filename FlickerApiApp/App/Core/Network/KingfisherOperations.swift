//
//  KingfisherOperations.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 16.10.2022.
//

import UIKit
import Kingfisher

struct KingfisherOperations{
    
    static let shared = KingfisherOperations()
    
    private init(){}
    
    func downloadImage(url: String, imageView: UIImageView, completion: @escaping (Bool) -> Void){
        let url = URL(string: url)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named:"photo_camera"),
            options: [
               // .processor(processor),
               // .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(_):
                completion(true)
                //print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                completion(false)
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
    func downloadProfileImage(url: String, imageView: UIImageView, completion: @escaping (Bool) -> Void){
        let url = URL(string: url)
        let processor = RoundCornerImageProcessor(cornerRadius: imageView.bounds.size.width / 2)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named:"photo_camera"),
            options: [
                .processor(processor),
                //.scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(_):
               // print("Task done for: \(value.source.url?.absoluteString ?? "")")
                completion(true)
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
        
}
