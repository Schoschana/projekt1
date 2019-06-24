//
//  DownloadsController.swift
//  frog
//
//  Created by Lili on 21/06/2019.
//  Copyright © 2019 Lili. All rights reserved.
//

import UIKit
class DownloadsController: UITableViewController {
    
    fileprivate let cellId = "cellId"
     var episodes = UserDefaults.standard.downloadedEpisodes()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupObservers()
        
        
    }
    fileprivate func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleDownloadProgress), name: .downloadProgress, object: nil)
    }
    @objc fileprivate func handleDownloadProgress() {
        print("123")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        episodes = UserDefaults.standard.downloadedEpisodes()
        tableView.reloadData()
    }
    
    // MARK: - Setup
    fileprivate func setupTableView() {
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
   
}
     // MARK: - UITableView
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Launch episode player")
        let episode = self.episodes[indexPath.row]
        
        if episode.fileUrl != nil {
             UIApplication.mainTabBarController()?.maximizePlayerDetails(episode: episode, playlistEpisodes: self.episodes)
        } else {
            let alertController = UIAlertController(title: "File URL not foud", message: "Cannot find local file , play using stream url instead ", preferredStyle: .actionSheet)
            
            alertController.addAction(UIAlertAction(title: "Yer", style: .default, handler: { (_) in
                 UIApplication.mainTabBarController()?.maximizePlayerDetails(episode: episode, playlistEpisodes: self.episodes)
            }))
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alertController, animated: true)
        }
       
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EpisodeCell
        cell.episode = self.episodes[indexPath.row]
        return cell
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    
        
    }
}
