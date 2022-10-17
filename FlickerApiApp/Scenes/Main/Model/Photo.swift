//
//  Photo.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 16.10.2022.
//

import Foundation

struct Photo: Codable {
    let id: String?
    let owner: String?
    let secret: String?
    let server: String?
    let farm: Int?
    let title: String?
    let datetaken: String?
    let ownername: String?
    let url_n: String?
}
