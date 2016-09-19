//
//  ImageofDayViewController.swift
//  Ephemeris - Daily Journal
//
//  Created by Abdulghafar Al Tair on 6/23/16.
//  Copyright © 2016 Abdulghafar Al Tair. All rights reserved.
//

import UIKit

class ImageofDayViewController: UIViewController {
    
    var image: UIImage?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backgroundView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.clipsToBounds = true
        if let imagewanted = image {
            imageView.image = imagewanted
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
