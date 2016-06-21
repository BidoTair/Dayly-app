//
//  MainScreenViewController.swift
//  Ephemeris - Daily Journal
//
//  Created by Abdulghafar Al Tair on 6/20/16.
//  Copyright © 2016 Abdulghafar Al Tair. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavBar() {
        let otherbutton  = UIButton(type: .Custom)
        let otherimage = UIImage(named: "Plus")
        otherbutton.setImage(otherimage, forState: .Normal)
        otherbutton.frame = CGRectMake(600.0, 600.0, 43.0, 43.0)
        otherbutton.layer.cornerRadius = otherbutton.frame.height/2
        otherbutton.contentMode = UIViewContentMode.ScaleAspectFill
        otherbutton.layer.borderWidth = 1
        otherbutton.clipsToBounds = true
        otherbutton.addTarget(self, action: #selector(self.presentNewEntryViewController), forControlEvents: .TouchUpInside)
        
        let plusButton = UIBarButtonItem(customView: otherbutton)
        self.navigationItem.setRightBarButtonItem(plusButton, animated: true)
        
        
        let button  = UIButton(type: .Custom)
        let image = UIImage(named: "profile")
        button.setImage(image, forState: .Normal)
        button.frame = CGRectMake(0.0, 0.0, 43.0, 43.0)
        button.layer.cornerRadius = button.frame.height/2
        button.contentMode = UIViewContentMode.ScaleAspectFill
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.presentProfileViewController), forControlEvents: .TouchUpInside)
        
        let profileButton = UIBarButtonItem(customView: button)
        self.navigationItem.setLeftBarButtonItem(profileButton, animated: true)
    }
    
    func presentNewEntryViewController() {
        let newEntryvc = NewEntryViewController(nibName: "NewEntryViewController", bundle: nil)
        self.presentViewController(newEntryvc, animated: true, completion: nil)
    }
    
    func presentProfileViewController() {
        let pvc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        self.presentViewController(pvc, animated: true, completion: nil)
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
