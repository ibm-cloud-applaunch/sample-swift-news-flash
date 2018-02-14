//
//  ViewController.swift
//  Newsflash
//
//  Created by Vittal Pai on 2/13/18.
//  Copyright © 2018 Vittal Pai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import IBMAppLaunch

class ViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    static var data:JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signUpBtn(_ sender: Any) {
        let user = userName.text?.lowercased()
        var isSubscribed = false
        showOverlay()
        if(user == "user1" || user == "user2" || user == "user3") {
            loadRSSFeeds(handler: { (success) in
                if (success)! {
                    if (user == "user1"){
                        isSubscribed = true
                    }
                    self.registerAppLaunch(username: user!, isSubscribed: isSubscribed, handler: { (success, failure) in
                        if (success != nil){
                            //AppLaunch Initialization Success
                            self.dismissOverlay()
                            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                            let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "navigationView") as! UINavigationController
                            self.present(vc, animated: true, completion: nil)
                        }
                        else {
                            // Show pop up
                            self.dismissOverlay()
                            self.showAlert("AppLaunch Intialization Failed, Try after sometime.")
                        }
                    })
                } else {
                    // Show pop up
                    self.dismissOverlay()
                    self.showAlert("News retreival failed, Try after sometime.")
                }
            })
        } else {
            // Show pop up
            dismissOverlay()
            showAlert("Invalid User ID")
        }
    }
    
    internal func loadRSSFeeds(handler : @escaping (_ Response: Bool?) -> Void) {
        Alamofire.request("https://newsapi.org/v2/top-headlines?sources=the-times-of-india&apiKey=57e52756282748ccb0f6699e02219858").responseJSON { response in
            print(response.result)   // result of response serialization
            let result = response.result.value
            if let dict = result as? Dictionary<String, AnyObject> {
                ViewController.data = JSON(dict["articles"])
                handler(true)
            } else {
                handler(false)
            }
        }
    }
    
    internal func registerAppLaunch(username: String, isSubscribed: Bool, handler: @escaping AppLaunchCompletionHandler) {
        let config = AppLaunchConfig.Builder().fetchPolicy(.REFRESH_ON_EVERY_START).cacheExpiration(1).eventFlushInterval(100).build()
        let user = AppLaunchUser.Builder(userId: username).custom(key: "isSubscribed", boolValue: isSubscribed).build()
        AppLaunch.sharedInstance.initialize(region: .US_SOUTH, appId: "1e22e2af-4b02-47a8-b2f0-863fbc833da1", clientSecret: "f9c6a74f-c0f3-4ab6-b1d2-bfa004aa07a9", config: config, user: user, completionHandler: handler)
    }
    
    func showAlert(_ message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func showOverlay() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func dismissOverlay() {
        dismiss(animated: false, completion: nil)
    }


}

