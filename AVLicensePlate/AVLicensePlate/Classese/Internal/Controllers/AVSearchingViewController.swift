//
//  AVSearchingViewController.swift
//  AVLicensePlate
//
//  Created by  on 11/19/15.
//  Copyright © 2015 KZ. All rights reserved.
//

import UIKit

class AVSearchingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    //view
    @IBOutlet weak var tbvLicenseList: UITableView!
    @IBOutlet weak var sbSearchField: UISearchBar!
    
    //data
    var arrLicenseList : [AVLicenseModel] = []
    var arrLicenseListSearch : [AVLicenseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        DATAHandlerGettingListLicense()
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
    
    //MARK: - TableView Delegate - Datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLicenseListSearch.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let strCellIdentifier : String = "AVLicenseCell"
        let cell  = tableView.dequeueReusableCellWithIdentifier(strCellIdentifier, forIndexPath: indexPath) as! AVLicenseCell
        
        cell.settingCellContent(arrLicenseListSearch[indexPath.row])
        
        return cell
    }
    
    //MARK: SearchBar Delegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText)
    }

    //MARK: Data Handler
    func DATAHandlerGettingListLicense () {
        SVProgressHUD.show()
        arrLicenseList.removeAll(keepCapacity: false)
        weak var wSelf = self
        AVCommonHelper.backgroundThread(background: { () -> Void in
            wSelf?.arrLicenseList = AVDatabaseManager.sharedInstance.getAllLicense()!
            
            wSelf?.arrLicenseListSearch = (wSelf?.arrLicenseList)!
            }) { () -> Void in
                wSelf?.tbvLicenseList.reloadData()
                SVProgressHUD.dismiss()
        }
    }
    
    func filterContentForSearchText (searchText : String) {
        var tempArr : [AVLicenseModel] = []
        for obj in self.arrLicenseList {
            tempArr.append(obj)
        }
        
        // filter takes a block that returns a boolean. True: keep the item, False: drop it.
        self.arrLicenseListSearch = tempArr.filter({
            $0.licenseID.containsString(searchText)
        })
        if self.arrLicenseListSearch.count == 0 {
            self.arrLicenseListSearch = self.arrLicenseList
        }
        self.tbvLicenseList.reloadData()
    }
}
