
//
//  PersistanceManager.swift
//  Xplore
//
//  Created by Abdulghafar Al Tair on 6/14/16.
//  Copyright © 2016 Abdulghafar Al Tair. All rights reserved.
//

import Foundation

class PersistenceManager {
    
    //Gets you the writing document directory path
    class private func documentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectory = paths[0] as String
        return documentDirectory
    }
    
    class func loadObject(filename:String) -> NSObject? {
        let file = documentsDirectory().stringByAppendingPathComponent(filename)
        let result = NSKeyedUnarchiver.unarchiveObjectWithFile(file)
        return result as? NSObject
    }
    
    class func saveObject(objectToSave: NSObject, fileName: String) {
        let file = documentsDirectory().stringByAppendingPathComponent(fileName)
        NSKeyedArchiver.archiveRootObject(objectToSave, toFile: file)
    }
    
    class func saveNSDictionary(arrayToSave: NSDictionary, fileName:String) {
        let file = documentsDirectory().stringByAppendingPathComponent(fileName)
        NSKeyedArchiver.archiveRootObject(arrayToSave, toFile: file)
    }
    
    class func loadNSDictionary(fileName:String) -> NSDictionary? {
        let file = documentsDirectory().stringByAppendingPathComponent(fileName)
        let result = NSKeyedUnarchiver.unarchiveObjectWithFile(file)
        return result as? NSDictionary
    }
}