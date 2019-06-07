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
        setupNavigationBarButtons()
    }
    
    //MARK: - Setup Work
    fileprivate func setupNavigationBarButtons() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(handleSaveFavorite)),
        UIBarButtonItem(title: "Fetch", style: .plain, target: self, action: #selector(handleFetchSavedPodcasts))]
   }
     @objc fileprivate func handleFetchSavedPodcasts() {
        print("Fetching saved Podcasts from UserDefaults")
        let value = UserDefaults.standard.value(forKey: favoritedPodcastKey) as? String
        print(value ?? "")
        
        // how  to retrieve our Podcast object from UserDefaults
        
        
        guard  let data = UserDefaults.standard.data(forKey: favoritedPodcastKey) else { return  }
        let podcast = NSKeyedUnarchiver.unarchiveObject(with: data) as? Podcast
        print(podcast?.trackName, podcast?.artistName)
    }
    let favoritedPodcastKey = "favoritedPodcastKey"
    
    
    @objc fileprivate func handleSaveFavorite() {
        print("Saving info into UserDefaults")
        
        guard let podcast = self.podcast else { return}
       // UserDefaults.standard.set(podcast.trackName, forKey: favoritedPodcastKey)
        // transform podcast
        let data = NSKeyedArchiver.archivedData(withRootObject: podcast)
        UserDefaults.standard.set(data, forKey: favoritedPodcastKey)
    }
    
    
    fileprivate func setupTableView() {
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: cellId)
    tableView.tableFooterView = UIView()
     }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
       activityIndicatorView.color = .darkGray
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return episodes.isEmpty ? 200 : 0
    }
    

//MARK:- UITableView
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     let episode = self.episodes[indexPath.row]
        let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as?
        MainTabBarController
        mainTabBarController?.maximizePlayerDetails(episode: episode, playlistEpisodes: self.episodes)
        
        
        
      
        
 
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
