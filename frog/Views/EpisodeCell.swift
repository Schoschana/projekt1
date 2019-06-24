//
//  EpisodeCell.swift
//  frog
//
//  Created by Lili on 01/05/2019.
//  Copyright © 2019 Lili. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {

    var episode: Episode! {
        didSet {
        
            titleLabel.text = episode.title
            descriptionLabel.text = episode.description
            let dataFormatter = DateFormatter()
            dataFormatter.dateFormat = " MMM dd, yyyy"
          pubDateLabel.text = dataFormatter.string(from: episode.pubDate)
            
            // url ?
            let url = URL(string: episode.imageUrl?.toSecureHTTPS() ?? "")
            episodeImageView.sd_setImage(with: url)
        }
    }
        
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var pubDateLabel: UILabel!
    
    
    @IBOutlet weak var titleLabel: UILabel!{
    
    didSet {
    titleLabel.numberOfLines = 2
     }
}
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet {
            descriptionLabel.numberOfLines = 2
        }
    }
    
   


 }
