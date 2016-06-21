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
    
    var entriesArray: [Entry] = []
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
        entriesArray.append(entry)
        
        PersistenceManager.saveNSArray(entriesArray, fileName: "entriesSaved")
    }
    
    private func readEntriesFromMemory() {
        let result = PersistenceManager.loadNSArray("placesVisited")
        let entries = result as? [Entry]
        if entries == nil {
            self.entriesArray += []
        }
        else {
            self.entriesArray += entries!
        }
    }
    
    func getPlaces() -> [Entry] {
            self.readEntriesFromMemory()
            return entriesArray
        }
        
}