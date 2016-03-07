//
//  User.swift
//  TwitterDemo
//
//  Created by Nashid  on 3/6/16.
//  Copyright © 2016 CodePath. All rights reserved.
//

import UIKit

class User: NSObject {
   
 //step 1: enumerate all your properties :-)
    var name: NSString?
    var screenname: NSString?
    var profileURL: NSURL?
    var tagline: NSString?
    
    var dictionary: NSDictionary?
    
    
//step 2: write a constructor that deserializes all the shit you got back from the internet into these properties
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        let profileURLString = dictionary["profile_image_url_https"] as? String
            if let profileURLString = profileURLString {
                profileURL  = NSURL(string: profileURLString)
        }else{
                profileURL = nil 
        
        }
        
        tagline = dictionary["description"] as? String
    }
    
    static let userDidLogoutNotification = "UserDidLogout"
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
        if _currentUser == nil {
        
            let defaults = NSUserDefaults.standardUserDefaults()
            
            let userData = defaults.objectForKey("currentUserData") as? NSData
        
        if let userData = userData{
            let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
        
            _currentUser = User(dictionary: dictionary)
        }
            
      }
            return _currentUser
    }
        set(user) {
            _currentUser = user
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user{
                let data  = try!  NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                
                
                defaults.setObject(data, forKey: "currentUserData")
            } else{
                defaults.setObject(user, forKey: "currentUser")
                
            }
            
            
            defaults.synchronize()
        }
        
    }
}
    

