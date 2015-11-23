//
//  AVLicenseModel.swift
//  AVLicensePlate
//
//  Created by  on 11/19/15.
//  Copyright © 2015 KZ. All rights reserved.
//

import UIKit

class AVLicenseModel: NSObject {
    var licenseID       : String = ""
    var licenseName     : String = ""
    var licenseStatus   : Bool = false
    
    enum AVLicenseModelKeyHelper : String {
        case licenseID      = "license_id"
        case licenseName    = "license_name"
        case licenseStatus  = "license_status"
    }
    
    override init(){
        super.init()
    }
    
    init(data: JSON) {
        super.init()
        if let licenseIDValue = data[AVLicenseModelKeyHelper.licenseID.rawValue].string {
            licenseID = licenseIDValue
        }
        
        if let licenseNameValue = data[AVLicenseModelKeyHelper.licenseName.rawValue].string {
            licenseName = licenseNameValue
        }
        
        if let licenseStatusValue = data[AVLicenseModelKeyHelper.licenseStatus.rawValue].string {
            if licenseStatusValue == "1" {
                licenseStatus = true
            } else {
                licenseStatus = false
            }
        }
    }
    
    init (data : AVLicenseModel) {
        super.init()
        self.licenseID       = data.licenseID
        self.licenseName     = data.licenseName
        self.licenseStatus   = data.licenseStatus
    }
    
    override func copy() -> AnyObject {
        let copyModel = AVLicenseModel(data: self)
        return copyModel
    }

}
