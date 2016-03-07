//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Nashid  on 3/6/16.
//  Copyright © 2016 CodePath. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "2UcS54UaHd38ZjgUkPYXo4ji2", consumerSecret: "U5K3w3Iy4gjjShjDffR396yxAsdI9RhPcOkVoqkMzjUzMHUJpY")

    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) ->())?
    
    
    func login(success: () -> (), failure: (NSError)->()){
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!)-> Void in
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            
            }) { (error: NSError!) -> Void in
                print ("error:\(error.localizedDescription)")
                self.loginFailure?(error)
                
        }
    
    }

    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken:BDBOAuth1Credential!) -> Void in
            
            self.loginSuccess?()
            
            })  { (error:NSError!) -> Void in
                    print("error: \(error.localizedDescription)")
                    self.loginFailure?(error)
        }

    
    }
    
    func homeTimeline(success: ([Tweet])->(), failure: (NSError)-> ()){
        
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)

            }, failure: { (task:NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }

    func currentAccount(){
                GET("1.1/account/verify_credentials.json",parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as! NSDictionary
            
            
            let user = User(dictionary: userDictionary)
            print ("user: \(user)")
            
            print ("name: \(user.name)")
            print("screenname: \(user.screenname)")
            print("profile url: \(user.profileURL)")
            print("description:\(user.tagline)")
            
            }, failure: { (task:NSURLSessionDataTask?, NSError) -> Void in
        })
        
    }
        
        
}





