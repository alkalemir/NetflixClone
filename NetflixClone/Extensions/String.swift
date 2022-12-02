//
//  String.swift
//  NetflixClone
//
//  Created by alkalemir on 2.12.2022.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
