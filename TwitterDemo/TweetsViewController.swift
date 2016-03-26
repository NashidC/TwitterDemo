//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Nashid  on 3/7/16.
//  Copyright © 2016 CodePath. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    var tweets: [Tweet]!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 250
        
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets:[Tweet]) -> () in
            self.tweets = tweets
            for tweet in tweets{
                print (tweet.text)
                self.tableView.reloadData()
            }
            }, failure: { (error:NSError) -> () in
                print(error.localizedDescription)
        })
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        let tweet = tweets[indexPath.row]
        
        cell.tweet = tweet
        
        // Profile image
        cell.profileView.setImageWithURL(tweet.profileImage!)
        cell.profileView.layer.cornerRadius = 3
        cell.profileView.clipsToBounds = true
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
