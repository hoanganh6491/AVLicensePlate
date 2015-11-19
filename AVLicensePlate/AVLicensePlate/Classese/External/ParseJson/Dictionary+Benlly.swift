//
//  Dictionary+Benlly.swift
//  Benlly
//
//  Created by haipt on 9/9/15.
//  Copyright (c) 2015 Curations. All rights reserved.
//

import Foundation

extension Dictionary {
    func floatOrZero(key: String) -> CGFloat {
        if let key_ = key as? Key {
            if let value = self[key_] as? CGFloat {
                return value
            }
        }
        return 0
    }
    
    func floatOrNil(key: String) -> CGFloat? {
        if let key_ = key as? Key {
            return self[key_] as? CGFloat
        }
        return nil
    }
    
    func doubleOrZero(key: String) -> Double {
        if let key_ = key as? Key {
            if let value = self[key_] as? Double {
                return value
            }
        }
        return 0
    }
    
    func doubleOrNil(key: String) -> Double? {
        if let key_ = key as? Key {
            return self[key_] as? Double
        }
        return nil
    }
    
    func intOrZero(key: String) -> Int {
        if let key_ = key as? Key {
            if let value = self[key_] as? Int {
                return value
            }
        }
        return 0
    }
    
    func intOrNil(key: String) -> Int? {
        if let key_ = key as? Key {
            return self[key_] as? Int
        }
        return nil
    }
    
    func stringOrEmpty(key: String) -> String {
        if let key_ = key as? Key {
            if let value = self[key_] as? String {
                return value
            }
        }
        return ""
    }
    
    func stringOrNil(key: String) -> String? {
        if let key_ = key as? Key {
            return self[key_] as? String
        }
        return nil
    }
    
    func boleanOrFalse(key: String) -> Bool {
        if let key_ = key as? Key {
            if let value = self[key_] as? Bool {
                return value
            }
        }
        return false
    }
    
    func boleanOrNil(key: String) -> Bool? {
        if let key_ = key as? Key {
            return self[key_] as? Bool
        }
        return nil
    }
}