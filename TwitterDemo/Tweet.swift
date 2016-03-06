//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Nashid  on 3/6/16.
//  Copyright © 2016 CodePath. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritescount: Int = 0
    
    
    init(dictionary:NSDictionary){
        text = dictionary["text"] as? String
        
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritescount = (dictionary["favorites_count"] as? Int ?? 0)
        
        let timestampString = dictionary["created_at"] as? String
        
        
        
        
        if let timestampString = timestampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        
        }
    
    }

    class func tweetsWithArray(dictionaries: [NSDictionary]) ->[Tweet]{
        var tweets = [Tweet]()   //create an array of tweets (its empty)
        
        for dictionary in dictionaries {        //iterate through all the dictionaries
            let tweet = Tweet(dictionary: dictionary)   //create a tweet based on that dictionary
            
            tweets.append(tweet)    //add tweet to array
        }
        
        return tweets           //return tweet obvi
        
    
    }
    
}
