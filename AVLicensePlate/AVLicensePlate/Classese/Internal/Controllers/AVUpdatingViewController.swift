//
//  AVUpdatingViewController.swift
//  AVLicensePlate
//
//  Created by  on 11/19/15.
//  Copyright © 2015 KZ. All rights reserved.
//

import UIKit

class AVUpdatingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: - Button Action
    
    @IBAction func btnUpdateDidTap(sender: AnyObject) {
        APIHandlerUpdatingDatabase()
    }
    
    //MARK: - API Handler
    func APIHandlerUpdatingDatabase () {
        AVCommonHelper.showHUD()
        let helper = AVApiHelper()
        weak var wSelf = self
        helper.callUpdateDatabase({ (result) -> () in

            AVCommonHelper.dissmissHUD()
            }) { (error) -> () in
            AVCommonHelper.dissmissHUD()                
        }
    }
}
