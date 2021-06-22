//
//  API.swift
//  vk-junior
//
//  Created by Artur Igberdin on 04.06.2021.
//

import Foundation
import Alamofire


class API {
    
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let cliendId = "12548602"
    let version = "5.21"
    

    func loadNews(completion: @escaping([News], [Group]?, [Profile]?) -> Void) {

        let method = "/newsfeed.get"
        
        let parameters: Parameters = [
            "user_ids": Session.shared.userId,
            "access_token": Session.shared.token,
            "filters": "post",
            "count": "100",
            "v": version
        ]
        
        let url = baseUrl + method
        
        print(url)
        print(parameters)

        AF.request(url, method: .get, parameters: parameters).responseData { response in
            
            guard let data = response.data else { return }
            print("PRETTY JSON = ", data.prettyJSON)
            
                do {
                    
                } catch {
                    print(error)
                }
        }
    }
    
    func getFriends(completion: @escaping([User])->()) {
        
        let method = "/friends.get"
        
        let parameters: Parameters = [
            "user_id": cliendId,
            "order": "name",
            "count": 100,
            "fields": "photo_100",
            "access_token": Session.shared.token,
            "v": version]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            
            guard let data = response.data else { return }
            print("PRETTY JSON = ", data.prettyJSON)
            
            
            
            let friendsResponse = try? JSONDecoder().decode(Friends.self, from: data)
            guard let friends = friendsResponse?.response.items else { return }
            
            DispatchQueue.main.async {
                completion(friends)
            }
        }
    }
    
    func getGroups(completion: @escaping()->()) {
        let method = "/groups.get"
        //https://vk.com/dev/groups.get
    }
    
    func searchGroups(completion: @escaping()->()) {
        let method = "/groups.search"
        //https://vk.com/dev/groups.search
    }
    
    func getPhotosByUser() {
        let method = "/photos.getAll"
        //https://vk.com/dev/photos.getAll
    }
}
