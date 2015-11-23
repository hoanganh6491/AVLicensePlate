//
//  AVLicenseCell.swift
//  AVLicensePlate
//
//  Created by  on 11/23/15.
//  Copyright © 2015 KZ. All rights reserved.
//

import UIKit

class AVLicenseCell: UITableViewCell {

    //view
    @IBOutlet weak var lblLicenseID: UILabel!
    @IBOutlet weak var lblLicenseName: UILabel!
    @IBOutlet weak var lblLicenseStatus: UILabel!

    //data
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    //MARK: - View Utils
    func settingCellContent (data: AVLicenseModel) {
        //license id
        lblLicenseID.text = data.licenseID
        
        //license name 
        lblLicenseName.text = data.licenseName
    
        //license status
        if data.licenseStatus {
            self.lblLicenseID.backgroundColor = UIColor.greenColor()
        } else {
            self.lblLicenseID.backgroundColor = UIColor.whiteColor()
        }
    }
}
