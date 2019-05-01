//
//  APIService.swift
//  frog
//
//  Created by Lili on 24/04/2019.
//  Copyright © 2019 Lili. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    let baseiTunesSearchURL = "https://itunes.apple.com/search"
    static let shared = APIService()
    
    func fetchMusic()  {
       baseiTunesSearchURL
    }
    func fetchPodcasts(searchText: String, completionHandler: @escaping ([Podcast]) -> ()) {
        print("Searching for podcasts...")
        
        
        
        let parameters = ["term": searchText, "media": "podcast"]
        
        Alamofire.request(baseiTunesSearchURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).response { (dataResponse) in
            if let err = dataResponse.error {
                print("Failed to contact yahoo", err)
                return
            }
            
            guard let data = dataResponse.data else {return }
        //let dummyString = String(data: data, encoding: .utf8)
            //  print(dummyString ?? "")
            
            do {
                print(3)
                let searchResult = try
                    JSONDecoder().decode(SearchResults.self, from: data)
                print( searchResult.resultCount)
                completionHandler(searchResult.results)
                
                   //searchResult.results.forEach({ (podcast) in
                //    print(podcast.artistName, podcast.trackName)
               // })
                
                //self.podcasts = searchResult.results
               // self.tableView.reloadData()
                
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
            }
            
        }
        print(2)
    }
    
    struct SearchResults: Decodable {
        let resultCount: Int
        let results: [Podcast]
    }
}
