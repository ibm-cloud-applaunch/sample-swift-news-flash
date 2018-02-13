//
//  RSSFeeds.swift
//  Newsflash
//
//  Created by Vittal Pai on 2/13/18.
//  Copyright © 2018 Vittal Pai. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


internal class RSSFeeds {
    internal static var sharedInstance = RSSFeeds()
    internal var data:JSON?
    
    init() {
        Alamofire.request("https://newsapi.org/v2/top-headlines?sources=the-times-of-india&apiKey=57e52756282748ccb0f6699e02219858").responseJSON { response in
            print(response.result)   // result of response serialization
            let result = response.result.value
            
            if let dict = result as? Dictionary<String, AnyObject> {
                 self.data = JSON(dict["articles"])
            }
            
            
//            let dataToConvert = result.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
//            do {
//                let json = try JSON(data: dataToConvert!)
//                 print(json)
//            } catch{
//              print(error)
//            }
//
           
            
        }
    }
    
    
    // With URLSession
}
