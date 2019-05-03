//
//  PlayerDetailsView.swift
//  frog
//
//  Created by Lili on 03/05/2019.
//  Copyright © 2019 Lili. All rights reserved.
//

import UIKit

class PlayerDetailsView: UIView {
    var episode: Episode! {
        didSet {
            titleLabel.text = episode.title
            
            guard let  url = URL(string: episode.imageUrl ?? "") else { return}
            episodeImageView.sd_setImage(with: url)
        }
    }
    
    @IBAction func handleDismiss(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    @IBOutlet weak var episodeImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
}
