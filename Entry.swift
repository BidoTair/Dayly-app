//
//  Entry.swift
//  Ephemeris - Daily Journal
//
//  Created by Abdulghafar Al Tair on 6/20/16.
//  Copyright © 2016 Abdulghafar Al Tair. All rights reserved.
//

import Foundation
import UIKit

class Entry: NSObject, NSCoding {
    
    var entryText: String?
    var imageofDay: UIImage?
    var backgroudImage: UIImage?
    var date: String?
    
    required init(text: String?, imageofDay: UIImage?, backgroudImage: UIImage?, date: String?) {
        self.entryText = text
        self.imageofDay = imageofDay
        self.backgroudImage = backgroudImage
        self.date = date
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.entryText, forKey: "text")
        aCoder.encodeObject(self.imageofDay, forKey: "imageofDay")
        aCoder.encodeObject(self.date, forKey: "date")
        aCoder.encodeObject(self.backgroudImage, forKey: "backgroundimage")
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let entryText = aDecoder.decodeObjectForKey("text") as? String
        let imageofDay = aDecoder.decodeObjectForKey("imageofDay") as? UIImage
        let date = aDecoder.decodeObjectForKey("date") as? String
        let backgroundimage = aDecoder.decodeObjectForKey("backgroundimage") as? UIImage
        
        
        self.init(text: entryText, imageofDay: imageofDay, backgroudImage: backgroundimage, date: date)
    }

    
}
