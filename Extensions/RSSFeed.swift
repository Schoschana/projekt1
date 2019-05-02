//
//  RSSFeed.swift
//  frog
//
//  Created by Lili on 02/05/2019.
//  Copyright © 2019 Lili. All rights reserved.
//

import FeedKit
extension RSSFeed {
    
    func toEpisodes () -> [Episode] {
        
let imageUrl = iTunes?.iTunesImage?.attributes?.href
var episodes = [Episode]() // blank Episode err

    items?.forEach({ (feedItem) in
    
    var episode = Episode(feedItem: feedItem)
    
    if episode.imageUrl == nil {
        episode.imageUrl = imageUrl
    }
    
    episodes.append(episode)
})
        return episodes
   

   }
    
}
