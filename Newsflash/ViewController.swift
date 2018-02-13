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

class ViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    static var data:JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRSSFeeds()
       // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signUpBtn(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "navigationView") as! UINavigationController
        self.present(vc, animated: true, completion: nil)
    }
    
    internal func loadRSSFeeds() {
        Alamofire.request("https://newsapi.org/v2/top-headlines?sources=the-times-of-india&apiKey=57e52756282748ccb0f6699e02219858").responseJSON { response in
            print(response.result)   // result of response serialization
            let result = response.result.value
            if let dict = result as? Dictionary<String, AnyObject> {
                ViewController.data = JSON(dict["articles"])
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


}

