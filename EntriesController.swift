//
//  EntriesController.swift
//  Ephemeris - Daily Journal
//
//  Created by Abdulghafar Al Tair on 6/20/16.
//  Copyright © 2016 Abdulghafar Al Tair. All rights reserved.
//

import Foundation
import UIKit


class EntriesController {
    
    var entriesDictionary = [String: Entry]()
    class var sharedInstance: EntriesController {
        struct Static {
            static var instance: EntriesController?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token)    {
            Static.instance = EntriesController()
        }
        return Static.instance!
    }
    
    func addEntry(text: String?,imageofDay: UIImage?, backgroundimage: UIImage?, date: String?) {
        let entry = Entry(text: text, imageofDay: imageofDay, backgroudImage: backgroundimage, date: date)
        entriesDictionary[date!] = entry
        
        PersistenceManager.saveNSDictionary(entriesDictionary, fileName: "entriesSaved")
    }
    
    private func readEntriesFromMemory() {
        let result = PersistenceManager.loadNSDictionary("entriesSaved")
        let entries = result as? [String: Entry]
        if  let ent = entries {
            for(date, entries) in ent {
                entriesDictionary.updateValue(entries, forKey: date)
            }
        }
    }



    func getEntries() -> [String: Entry] {
            self.readEntriesFromMemory()
            return entriesDictionary
        }
    
    func getnumberofEntries() -> Int {
        self.readEntriesFromMemory()
        var numberofentries = 0
        for(_, _) in entriesDictionary {
            numberofentries += 1
        }
        return numberofentries
    }
        
}