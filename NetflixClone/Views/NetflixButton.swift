//
//  NetflixButton.swift
//  NetflixClone
//
//  Created by alkalemir on 2.12.2022.
//

import UIKit

class ButtonCreator {
    static func createButton(title: String, tint: UIColor, textFont: UIFont?, imageName: String?) -> UIButton {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(title, for: .normal)
        btn.tintColor = tint
        btn.titleLabel?.font = textFont
        
        if let imageName {
            btn.setImage(UIImage(systemName: imageName), for: .normal)
        }
        
        return btn
    }
}

extension UIButton {
    func configureBorder() {
        layer.cornerRadius = 3
        backgroundColor = .white
        setTitleColor(.black, for: .normal)
    }
}
