//
//  StringExtension.swift
//  Benlly
//
//  Created by  on 9/14/15.
//  Copyright (c) 2015 Curations. All rights reserved.
//

import Foundation

extension String {
    func replaceCharacter(wordFind: String, replaceByWord: String) -> String {
        return stringByReplacingOccurrencesOfString(wordFind, withString: replaceByWord, options: .LiteralSearch, range: nil)
    }
    
    var lastPathComponent: String {
        get {
            return (self as NSString).lastPathComponent
        }
    }
    
    var pathExtension: String {
        get {
            return (self as NSString).pathExtension
        }
    }
    
    var stringByDeletingLastPathComponent: String {
        get {
            return (self as NSString).stringByDeletingLastPathComponent
        }
    }
    
    var stringByDeletingPathExtension: String {
        get {
            return (self as NSString).stringByDeletingPathExtension
        }
    }
    
    var pathComponents: [String] {
        get {
            return (self as NSString).pathComponents
        }
    }
    
    var getMIMEVideoType : String {
        let arrStr = self.componentsSeparatedByCharactersInSet(NSCharacterSet (charactersInString: "."))
        return arrStr.last!
    }
    
    func stringByAppendingPathComponent(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.stringByAppendingPathComponent(path)
    }
    
    func stringByAppendingPathExtension(ext: String) -> String? {
        let nsSt = self as NSString
        return nsSt.stringByAppendingPathExtension(ext)  
    }
}