//
//  CollectionViewCell.swift
//  NetflixClone
//
//  Created by alkalemir on 2.12.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    var moviePosterPath: String? {
        didSet {
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(moviePosterPath ?? "")")
            URLSession.shared.dataTask(with: url!) { data, _, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
                
            }.resume()
            
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkGray
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
