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
        
        APIService.shared.fetchEpisodes(feedUrl: feedUrl) { (episodes) in
            self.episodes = episodes
            DispatchQueue.main.async {
            self.tableView.reloadData()
        }
         }
        
        
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl :
        feedUrl.replacingOccurrences(of: "http", with: "https")
        
        
        guard let url = URL(string: secureFeedUrl) else { return }
        let parser = FeedParser(URL: url)
        parser.parseAsync(result: {( result) in
            print("Successfully parse feed:", result.isSuccess)
            // associative enumeration values
            
            
            
            if let err = result.error {
                print("Failed to parse XML feed:", err)
                return
            }
            guard let feed = result.rssFeed else { return}
            self.episodes = feed.toEpisodes()
            DispatchQueue.main.async {
                self.tableView.reloadData()
               
            }
          
         })
    }
    
    fileprivate let cellId = "cellId"
    
    
    var episodes = [Episode] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    //MARK: - Setup Work
    fileprivate func setupTableView() {
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: cellId)
    tableView.tableFooterView = UIView()
     }
    
    

//MARK:- UITableView
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = self.episodes[indexPath.row]
        print("Trying to play episode:", episode.title)
        
       let window = UIApplication.shared.keyWindow
        
        let playerDetailsView = Bundle.main.loadNibNamed("PlayerDetailsView", owner: self, options: nil)?.first as!PlayerDetailsView
        
        
        playerDetailsView.episode = episode
        
        playerDetailsView.frame = self.view.frame
        window?.addSubview(playerDetailsView)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EpisodeCell
        
        let episode = episodes[indexPath.row]
        cell.episode = episode
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
        
    }

  }
