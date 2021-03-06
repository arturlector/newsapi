//
//  ViewController.swift
//  vk-junior
//
//  Created by Artur Igberdin on 04.06.2021.
//

import UIKit
import WebKit
import SwiftKeychainWrapper


class AuthViewController: UIViewController, WKNavigationDelegate {

   
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //KeychainWrapper.standard.set("", forKey: "vkToken")
        
//        if let token = KeychainWrapper.standard.string(forKey: "vkToken"), !token.isEmpty {
//
//            Session.shared.token = token
//            showMainTabBar()
//            return
//        }
        
        authorizateToVK()
    }

    //MARK: - Private
    
//    let cliendId = "12548602"
//
//    let version = "5.131"
    
    //scope = 270342
    //URLQueryItem(name: "scope", value: "262150"),
    
    private func authorizateToVK() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7822904"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "270342"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
    }
    
    //MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment  else {
                    decisionHandler(.allow)
                    return
            }
        
        let params = fragment
                    .components(separatedBy: "&")
                    .map { $0.components(separatedBy: "=") }
                    .reduce([String: String]()) { result, param in
                        var dict = result
                        let key = param[0]
                        let value = param[1]
                        dict[key] = value
                        return dict
                }
        
        if let token = params["access_token"], let userId = params["user_id"]  {
            print("TOKEN = ", token as Any)
            KeychainWrapper.standard.set(token, forKey: "vkToken")
            Session.shared.token = token
            Session.shared.userId = userId
            showMainTabBar()
        }
        
        decisionHandler(.cancel)
    }
    
    //MARK: - Routing
    
    func showMainTabBar() {
        performSegue(withIdentifier: "showHomeTabBarSegue", sender: nil)
    }
    

}

