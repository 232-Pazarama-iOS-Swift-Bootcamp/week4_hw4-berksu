//
//  ProfileViewController.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 16.10.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    var profileView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //view.backgroundColor = .blue
        view = profileView
        profileView.name = "Berksu"
    }
}
