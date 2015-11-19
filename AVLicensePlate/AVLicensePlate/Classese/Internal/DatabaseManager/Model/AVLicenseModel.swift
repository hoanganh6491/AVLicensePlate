//
//  AVLicenseModel.swift
//  AVLicensePlate
//
//  Created by  on 11/19/15.
//  Copyright © 2015 KZ. All rights reserved.
//

import UIKit

class AVLicenseModel: NSObject {
    var licenseID: Int = 0
    var licenseName: String = ""

    
    override init(){
        super.init()
    }
    
    init(data: JSON) {
        if let licenseIDValue = data["id"].int {
            licenseID = licenseIDValue
        }
        
        if let licenseNameValue = data["name"].string {
            licenseName = licenseNameValue
        }
    }
    
    init (data : AVLicenseModel) {
        super.init()
        self.licenseID             = data.licenseID
        self.licenseName     = data.licenseName
    }
    
    override func copy() -> AnyObject {
        let copyModel = AVLicenseModel(data: self)
        return copyModel
    }

}
