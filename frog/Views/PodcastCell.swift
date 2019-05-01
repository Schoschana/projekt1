//
//  PodcastCell.swift
//  frog
//
//  Created by Lili on 24/04/2019.
//  Copyright © 2019 Lili. All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell {
    @IBOutlet weak var podcastImageView: UIImageView!
    
    @IBOutlet weak var trackNameLabel: UILabel!
    
    
    @IBOutlet weak var artistNameLabel: UILabel!
    
    @IBOutlet weak var episodeCountLabel: UILabel!
    
    
    
    var podcast: Podcast! {
        didSet {
            trackNameLabel.text = podcast.trackName
            artistNameLabel.text = podcast.artistName
            
            
            episodeCountLabel.text  = "\(podcast.trackCount ?? 0) Episodes"
            
            print("Loading image  with url:", podcast.artworkUrl600 ?? "")
            guard  let url = URL(string: podcast.artworkUrl600 ?? "") else { return }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                print("Finished downloading image data:", data)
                
                guard let data = data else { return }
                
              self.podcastImageView.image = UIImage(data: data)
               
                
            }.resume()
        }
    }
}
