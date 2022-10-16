//
//  TabBarViewController.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 16.10.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupViewControllers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // Create all of the tabs and icons of the tabs
    func setupViewControllers(){
        viewControllers = [
            createNavigationController(for: MainViewController(),
                                       title: NSLocalizedString("Home", comment: ""),
                                       image: UIImage(named:"home")!),
            createNavigationController(for: SearchViewController(),
                                       title: NSLocalizedString("Photos", comment: ""),
                                       image: UIImage(named:"recentPhotos")!),
            createNavigationController(for: ProfileViewController(),
                                       title: NSLocalizedString("Profile", comment: ""),
                                       image: UIImage(named:"person")!)
        ]
    }
    
    func createViewControllerForEachPage(for vc: UIViewController, title: String, image: UIImage) -> UIViewController{
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        vc.navigationItem.title = title
        return vc
    }
    
    fileprivate func createNavigationController(for rootViewController: UIViewController,
                                                title: String,
                                                image: UIImage) -> UIViewController{
        // add navigation controller to each tab
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navigationController
    }
    
}
