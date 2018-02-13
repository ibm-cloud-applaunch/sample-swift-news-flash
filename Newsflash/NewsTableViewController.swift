//
//  NewsTableViewController.swift
//  Newsflash
//
//  Created by Vittal Pai on 2/13/18.
//  Copyright © 2018 Vittal Pai. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (RSSFeeds.sharedInstance.data?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RSSItem", for: indexPath) as! NewsTableViewCell
        let feed = RSSFeeds.sharedInstance.data![indexPath.row]
        cell.rssTitle.text = feed["title"].stringValue
        cell.rssDescription.text = feed["description"].stringValue
        cell.rssDescription.textContainer.maximumNumberOfLines = 2
        cell.rssDescription.textContainer.lineBreakMode = .byTruncatingTail
        var imageData:NSData
        do {
            if(!feed["urlToImage"].stringValue.isEmpty){
                imageData = try NSData(contentsOf: URL(string: feed["urlToImage"].stringValue)!)
            }else{
                imageData = NSData()
            }
        } catch  {
            imageData = NSData()
        }
        cell.rssImage.image = UIImage(data: imageData as Data)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
