//
//  AVCommonHelper.swift
//  AVLicensePlate
//
//  Created by  on 11/19/15.
//  Copyright © 2015 KZ. All rights reserved.
//

import UIKit

class AVCommonHelper: NSObject {

    class func Log (message: Any...) {
        print(message)
    }
    
    class func showHUD () {
        SVProgressHUD.show()
    }
    
    class func dissmissHUD () {
        SVProgressHUD.dismiss()
    }
}
