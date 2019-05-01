//
//  Episode.swift
//  frog
//
//  Created by Lili on 01/05/2019.
//  Copyright © 2019 Lili. All rights reserved.
//

import Foundation
import FeedKit

struct Episode {
    let title: String
    let pubDate: Date
    let description: String
    
    var imageUrl: String?
    
    init(feedItem: RSSFeedItem) {
        self.title = feedItem.title ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.description = feedItem.description ?? ""
        
        
       self.imageUrl =  feedItem.iTunes?.iTunesImage?.attributes?.href 
    }
}
