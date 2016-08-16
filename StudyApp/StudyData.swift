//
//  StudyData.swift
//  StudyApp
//
//  Created by 濱崎 裕太 on 2016/08/15.
//  Copyright © 2016年 YuleTeam. All rights reserved.
//

import Foundation
import NCMB

// @objc(StudyData)
class StudyData: NCMBObject, NCMBSubclassing{
   
    var userId: String! {
        get {
            return objectForKey("user_id") as! String
        }
        set {
            setObject(newValue, forKey: "user_id")
        }
    }
//    
//    var startTime: String! {
//        get {
//            return objectForKey("startTime") as! String
//        }
//        set {
//            setObject(newValue, forKey: "startTime")
//        }
//    }
    
    var startDate: NSDate! {
        get {
            return objectForKey("startDate") as! NSDate
        }
        set {
            setObject(newValue, forKey: "startDate")
        }
    }
    
    var interval: UInt {
        get {
            return objectForKey("Interval") as! UInt
        }
        set {
            setObject(newValue, forKey: "Interval")
        }
    }
    
    static func ncmbClassName() -> String! {
        return "StudyData"
    }
}
