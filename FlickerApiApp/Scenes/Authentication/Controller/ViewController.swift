//
//  ViewController.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 12.10.2022.
//

import UIKit

class ViewController: UIViewController {

    let authenticationView = AuthenticationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        view = authenticationView
    }


}

