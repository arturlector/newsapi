//
//  FriendsViewController.swift
//  vk-junior
//
//  Created by Artur Igberdin on 04.06.2021.
//

import UIKit
import SDWebImage


class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var apiService = API()
    var friends: [User] = []

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let group = DispatchGroup()
//        
//        group.enter()
//        apiService.getFriends { [weak self] users in
//            guard let self = self else { return }
//            self.friends = users
//            group.leave()
//        }
//        
//        group.notify(queue: .main) { [weak self] in
//            guard let self = self else { return }
//            self.tableView.reloadData()
//        }
//        
        apiService.loadNews { news, groups, profile in
            
            print(news)
            
        }
        
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let friend = friends[indexPath.row]
        cell.textLabel?.text = "\(friend.firstName) \(friend.lastName)"
        cell.imageView?.sd_setImage(with: URL(string: friend.photo100), placeholderImage: UIImage())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

}
