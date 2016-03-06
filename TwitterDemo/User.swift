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
    
//step 2: write a constructor that deserializes all the shit you got back from the internet into these properties
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        let profileURLString = dictionary["profile_image_url_https"] as? String
            if let profileURLString = profileURLString {
                profileURL  = NSURL(string: profileURLString)
        
        }
        
        tagline = dictionary["description"] as? String
    }

}
