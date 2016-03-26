//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Nashid  on 3/26/16.
//  Copyright © 2016 CodePath. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func retweetAction(sender: AnyObject) {
        
        if(tweet?.retweeted == 0){
            retweetButton.setImage(UIImage(named: "retweet-action-green"), forState: .Normal)
            retweetCountLabel.textColor = UIColor.greenColor()
            tweet?.retweeted = 1
            
            var pastRetweet = Int(self.retweetCountLabel.text!)
            pastRetweet = pastRetweet! + 1
            self.retweetCountLabel.text = String(pastRetweet!)
            
        }
        else{
            retweetButton.setImage(UIImage(named: "retweet-action-gray"), forState: .Normal)
            retweetCountLabel.textColor = UIColor.grayColor()
            tweet?.retweeted = 0
            
            var pastRetweet = Int(self.retweetCountLabel.text!)
            pastRetweet = pastRetweet! - 1
            self.retweetCountLabel.text = String(pastRetweet!)
            
        }
    }
    
    
    @IBAction func favoritedAction(sender: AnyObject) {
        
        if (tweet?.favorited == 0) {
            likeButton.setImage(UIImage(named: "like-action-red"), forState: .Normal)
            likeCountLabel.textColor = UIColor.redColor()
            tweet?.favorited = 1
            var pastFavorite = Int(self.likeCountLabel.text!)
            pastFavorite = pastFavorite! + 1
            self.likeCountLabel.text = String(pastFavorite!)
            
        } else {
            likeButton.setImage(UIImage(named: "like-action-gray"), forState: .Normal)
            likeCountLabel.textColor = UIColor.grayColor()
            tweet?.favorited = 0
            
            var pastFavorite = Int(self.likeCountLabel.text!)
            pastFavorite = pastFavorite! - 1
            self.likeCountLabel.text = String(pastFavorite!)
        }
        
    }
}
