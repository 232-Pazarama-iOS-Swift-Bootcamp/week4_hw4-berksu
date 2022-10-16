//
//  RecentPhotosResponse.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 16.10.2022.
//

import Foundation

struct RecentPhotosResponse: Decodable {
    let photos: Photos?
    let stat: String?
}

