//
//  UIViewController.swift
//  NetflixClone
//
//  Created by alkalemir on 1.12.2022.
//

import UIKit

extension UIViewController {
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
