//
//  BFDatabaseManager.swift
//  Benlly
//
//  Created by  on 10/6/15.
//  Copyright © 2015 Curations. All rights reserved.
//

import UIKit

class AVDatabaseManager : NSObject {
    var database: FMDatabase!
    var allIdeaTracked : [AVLicenseModel]! = []
    
    //MARK: - Init
    class var sharedInstance : AVDatabaseManager {
        struct Static {
            static let instance : AVDatabaseManager = AVDatabaseManager()
        }
        return Static.instance
    }
    
    var license_id      : String        = ""
    var license_name    : String        = ""
    var license_status  : Bool          = false

    override init() {
        super.init()
    }
    
    enum DatabaseConstant : String {
        case DatabaseName   = "licenseplate"
        
        case DatabaseTableName  = "licenses"
        
        case LicenseID      = "license_id"
        case LicenseName    = "license_name"
        case LicenseStatus  = "license_status"
    }
    
    func gettingDatabasePath() -> String {
        let documentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        AVCommonHelper.Log("database path = " + documentsFolder.stringByAppendingPathComponent(String(format:"%@.sqlite",DatabaseConstant.DatabaseName.rawValue)))
        return documentsFolder.stringByAppendingPathComponent(String(format:"%@.sqlite",DatabaseConstant.DatabaseName.rawValue))
    }
    
    /*
    Only call 1 time when start app
    */
    func creatingDatabase () {
        database = FMDatabase(path: gettingDatabasePath())
        if database.open() {
            if !database.tableExists(DatabaseConstant.DatabaseTableName.rawValue) {
                let createImageTableQuery = String(format :"CREATE TABLE IF NOT EXISTS %@(license_id VARCHAR, license_name VARCHAR, license_status BOOL)", DatabaseConstant.DatabaseTableName.rawValue)
                if database.executeUpdate(createImageTableQuery, withArgumentsInArray: nil) {
                    AVCommonHelper.Log(String(format:"Create table:%@ ",DatabaseConstant.DatabaseTableName.rawValue))
                }
            }
            database.close()
        }
    }
    
    func getAllLicense () -> [AVLicenseModel]? {
        if database.open() {
            var arrData : [AVLicenseModel] = []
            
            let strQuery = String(format:"SELECT * FROM %@",DatabaseConstant.DatabaseTableName.rawValue)
            let resultSet = database.executeQuery(strQuery, withArgumentsInArray: nil)
            
            if resultSet == nil {
                database.close()
                return nil
            } else {
                while resultSet.next() {
                    let thisLicensePlate = AVLicenseModel()
                    thisLicensePlate.licenseID = resultSet.objectForColumnName("license_id") as! String
                    thisLicensePlate.licenseName = resultSet.objectForColumnName("license_name") as! String
                    let smt = resultSet.objectForColumnName("license_status") as! String
                    if smt == "true" {
                        thisLicensePlate.licenseStatus = true
                    } else {
                        thisLicensePlate.licenseStatus = false
                    }
                    arrData.append(thisLicensePlate)
                }
                database.close()
                return arrData
            }
        }
        return nil
    }
    
    func insertLicenses (data: [AVLicenseModel]) {
        if database.open() {
            let tableName = DatabaseConstant.DatabaseTableName.rawValue
            let deleteQuery = String (format: "DELETE FROM %@",tableName)
            if database.executeUpdate(deleteQuery, withArgumentsInArray: nil) {
                AVCommonHelper.Log("!!!!!License DELETE ALL successful!!!!!!")                
                for object in data {
                    let insertQuery = String(format:"INSERT INTO %@ (license_id, license_name, license_status) VALUES ('\(object.licenseID)','\(object.licenseName)','\(object.licenseStatus)')",tableName)
                    if !database.executeUpdate(insertQuery, withArgumentsInArray: nil) {
                        AVCommonHelper.Log("!!!!!License insert failed!!!!!!")
                    } else {
                        AVCommonHelper.Log("!!!!!License insert successful!!!!!!")
                    }
                }
            } else {
                AVCommonHelper.Log("!!!!!DELETE failure!!!!!!")
            }
            
            database.close()
        }
    }
}

