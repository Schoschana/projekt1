//
//  EpisodesController.swift
//  frog
//
//  Created by Lili on 01/05/2019.
//  Copyright © 2019 Lili. All rights reserved.
//

import UIKit
import FeedKit


class EpisodesController: UITableViewController {
    
    var podcast: Podcast? {
        didSet {
            navigationItem.title = podcast?.trackName
            fetchEpisodes()
            
        }
    }
    fileprivate func fetchEpisodes() {
        print("Looking for episodes at url:" , podcast?.feedUrl ?? "")
        
        guard let feedUrl = podcast?.feedUrl else { return }
        
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl :
        feedUrl.replacingOccurrences(of: "http", with: "https")
        
        
        guard let url = URL(string: secureFeedUrl) else { return }
        let parser = FeedParser(URL: url)
        parser.parseAsync(result: {( result) in
            print("Successfully parse feed:", result.isSuccess)
            // associative enumeration values
            
            switch result {
           case let .rss(feed):
                var episodes = [Episode]() // blank Episode err
                
                feed.items?.forEach({ (feedItem) in
                    let episode = Episode(title: feedItem.title ?? "")
                    episodes.append(episode)
                })
                
                self.episodes = episodes
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                
                
                
                break
            case let .failure(error):
                print("Failed to parse feeed:", error)
                break
                
            default:
                print("Found a feed....")
            }
          
         })
    }
    
    fileprivate let cellId = "cellId"
    
    struct Episode {
        let title: String
    }
    var episodes = [
        Episode(title: "First Episode"),
        Episode(title: "Second Episode"),
        Episode(title: "Third Episode"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    //MARK: - Setup Work
    fileprivate func setupTableView() {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    tableView.tableFooterView = UIView()
     }
    
    

//MARK:- UITableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let episode = episodes[indexPath.row]
        cell.textLabel?.text = episode.title
        return cell
    }

  }
