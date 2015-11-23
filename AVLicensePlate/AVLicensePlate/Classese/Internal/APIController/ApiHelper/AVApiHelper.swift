//
//  AVApiHelper.swift
//  AVLicensePlate
//
//  Created by  on 11/19/15.
//  Copyright © 2015 KZ. All rights reserved.
//

import UIKit

class AVApiHelper: NSObject {
    override init() {
        super.init()
    }
    
    enum AVApiHelperKeyHelper : String {
        case action     = "action"
        case get_all    = "get_all"
        case insert_new_book = "insert_new_book"
    }
    
    func callUpdateDatabase (complete:([AVLicenseModel]) -> (), failed: (NSError?) -> ()) {
        let params: NSMutableDictionary = NSMutableDictionary()
        params[AVApiHelperKeyHelper.action.rawValue] = AVApiHelperKeyHelper.get_all.rawValue
        
        let apiUrl = AVApiURL_update
        let apiHelper: BFNetworkHelper = BFNetworkHelper(url: apiUrl, httpMethod: .POST, parameter: params)
        apiHelper.startService({ (response) -> Void in
                let json = JSON(response!)
                AVCommonHelper.Log("successfully!")
                if let arrayData = json.array {
                    var newsList: [AVLicenseModel] = []
                    for obj in arrayData {
                        let news = AVLicenseModel(data: obj)
                        newsList.append(news)
                    }
                    complete(newsList)
                } else {
                    AVCommonHelper.Log("1-- failed!")
                    failed(nil)
                }
        }) { (error) -> Void in
            AVCommonHelper.Log("2-- failed!")
            failed(nil)
        }
    }
}
