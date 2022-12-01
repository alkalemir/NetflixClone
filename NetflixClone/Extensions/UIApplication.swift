//
//  UIApplication.swift
//  NetflixClone
//
//  Created by alkalemir on 1.12.2022.
//

import UIKit

extension UIApplication {
    static func statusBarHeight() -> CGFloat {
        return UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
}
