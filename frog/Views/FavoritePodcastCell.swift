//
//  FavoritePodcastCell.swift
//  frog
//
//  Created by Lili on 06/06/2019.
//  Copyright © 2019 Lili. All rights reserved.
//

import UIKit
class FavoritePodcastCell: UICollectionViewCell {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "appicon"))
    let nameLabel = UILabel()
    let artistNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        
        nameLabel.text = "Podcast Name"
        artistNameLabel.text = "Artist Name"
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, artistNameLabel])
        stackView.axis = .vertical
        
        stackView.axis = .vertical
        
        // enable autp layout
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
       stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
