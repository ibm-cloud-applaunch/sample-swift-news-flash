//
//  ArticleViewController.swift
//  Newsflash
//
//  Created by Vittal Pai on 2/13/18.
//  Copyright © 2018 Vittal Pai. All rights reserved.
//

import UIKit
import IBMAppLaunch

class ArticleViewController: UIViewController {
    
    var articleTitle:String?
    var articleDescription:String?
    var articleImage:UIImage?
    var authorName:String?
    @IBOutlet weak var shareButton: UIImageView!
    @IBOutlet weak var rssDescription: UITextView!
    @IBOutlet weak var rssImage: UIImageView!
    @IBOutlet weak var rssTitle: UILabel!
    @IBOutlet weak var rssAuthor: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rssTitle.numberOfLines = 3
        rssTitle.text = articleTitle
        rssDescription.text = articleDescription
        if (authorName?.isEmpty)!{
            authorName = "By Anonymous"
        } else {
            authorName = "By " + authorName!
        }
        rssAuthor.text = authorName
        rssImage.image = articleImage
        var showShareButton:String="";
        do {
            showShareButton = try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "", propertyCode: "")
        }
        catch{
            print("Not initalized")
        }
        
        if(showShareButton.compare("true").rawValue == 0){
            shareButton.isHidden = false
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
