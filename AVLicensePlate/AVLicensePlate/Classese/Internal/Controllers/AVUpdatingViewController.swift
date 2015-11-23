//
//  AVUpdatingViewController.swift
//  AVLicensePlate
//
//  Created by  on 11/19/15.
//  Copyright © 2015 KZ. All rights reserved.
//

import UIKit

class AVUpdatingViewController: UIViewController {

    //view
    @IBOutlet weak var tfIPAddress: UITextField!
    
    
    //data
    var strIPAddress : String = ""
    
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
//        if !gettingIPAddress() {
//            return
//        }
        
        AVCommonHelper.showHUD()
        let helper = AVApiHelper()
        helper.callUpdateDatabase({ (result) -> () in
            AVDatabaseManager.sharedInstance.insertLicenses(result)
            AVCommonHelper.Log("insert successfully!")
            AVCommonHelper.dissmissHUD()
            }) { (error) -> () in
            AVCommonHelper.dissmissHUD()                
        }
    }
    
    func gettingIPAddress () -> Bool {
        var flag = true
        strIPAddress = tfIPAddress.text!
        
        if strIPAddress.characters.count == 0 {
            flag = false
        } else {
            flag = true
        }
        
        return flag
    }
}
