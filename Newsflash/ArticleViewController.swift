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
    @IBOutlet weak var rssDescription: UITextView!
    @IBOutlet weak var rssImage: UIImageView!
    @IBOutlet weak var rssTitle: UILabel!
    @IBOutlet weak var rssAuthor: UILabel!
    @IBOutlet weak var shareIcon: UIImageView!
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    internal func checkIfShareIconEnabled() {
        do {
            let flag = try AppLaunch.sharedInstance.isFeatureEnabled(featureCode: "FEATURE-CODE")
            if (flag) {
                self.shareIcon.isHidden = false
            }
        } catch {
          // AppLaunch Error
        }
    }

}
