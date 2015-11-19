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
        case action = "action"
        case insert_new_data = "insert_new_book"
        case books  = "books"
        case id     = "id"
        case name   = "name"
    }
    
    func callUpdateDatabase (complete:([AVLicenseModel]) -> (), failed: (NSError?) -> ()) {
        let params: NSMutableDictionary = NSMutableDictionary()
        params[AVApiHelperKeyHelper.action.rawValue] = AVApiHelperKeyHelper.insert_new_data.rawValue
        
        var arrData : [AVLicenseModel] = []
        for var i : Int = 0; i < 10; i++ {
            let object : AVLicenseModel = AVLicenseModel()
            object.licenseID = i
            object.licenseName = String(format: "name-%d", arguments: [i])
            arrData.append(object)
        }
        for var i = 0 ; i < arrData.count; i++ {
            let obj : AVLicenseModel = arrData[i]
            let strIDKey : String = "\(AVApiHelperKeyHelper.books.rawValue)[\(i)][\(AVApiHelperKeyHelper.id.rawValue)]"
            params[strIDKey] = obj.licenseID
            
            
            let strNameKey : String = "\(AVApiHelperKeyHelper.books.rawValue)[\(i)][\(AVApiHelperKeyHelper.name.rawValue)]"
            params[strNameKey] = obj.licenseName
        }
        
        let apiUrl = AVApiURL_update
        let apiHelper: BFNetworkHelper = BFNetworkHelper(url: apiUrl, httpMethod: .GET, parameter: params)
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
