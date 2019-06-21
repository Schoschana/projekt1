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
    
    override func viewDidLoad() {
        setupTableView()
        
    }
    
    // MARK: - Setup
    fileprivate func setupTableView() {
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
   
}
     // MARK: - UITableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EpisodeCell
        return cell
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    
        
    }
}
