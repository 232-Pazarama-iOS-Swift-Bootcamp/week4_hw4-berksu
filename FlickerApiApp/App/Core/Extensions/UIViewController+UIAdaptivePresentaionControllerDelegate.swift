//
//  UIViewController+UIAdaptivePresentaionControllerDelegate.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 19.10.2022.
//

import UIKit

extension UIViewController: UIAdaptivePresentationControllerDelegate {
    public func presentationControllerDidDismiss( _ presentationController: UIPresentationController) {
        viewWillAppear(true)
    }
}
