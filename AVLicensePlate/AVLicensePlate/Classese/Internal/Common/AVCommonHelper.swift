//
//  AVCommonHelper.swift
//  AVLicensePlate
//
//  Created by  on 11/19/15.
//  Copyright © 2015 KZ. All rights reserved.
//

import UIKit
import Foundation

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
    
    var GlobalMainQueue: dispatch_queue_t {
        return dispatch_get_main_queue()
    }
    
    class func backgroundThread(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
            if(background != nil){ background!(); }
            
            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue()) {
                if(completion != nil){ completion!(); }
            }
        }
    }
}
