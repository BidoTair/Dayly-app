//
//  ProfileViewController.swift
//  Ephemeris - Daily Journal
//
//  Created by Abdulghafar Al Tair on 6/20/16.
//  Copyright © 2016 Abdulghafar Al Tair. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit

protocol pictureDelegate {
    func changephoto(image: UIImage?)
}

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FBSDKLoginButtonDelegate {

    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet weak var publishButton: UIButton!
    @IBOutlet weak var numberofEntrieslabel: UILabel!
    
    let imagePicker = UIImagePickerController()
    let profile = FBSDKProfilePictureView()
    var delegate: pictureDelegate?
    var facebookImage: UIImage?
    
    override func viewDidLoad() {
        self.navigationController?.navigationBarHidden = true
        let loginButton: FBSDKLoginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        self.view!.addSubview(loginButton)
        
//        let shareButton: FBSDKShareButton = FBSDKShareButton()
//        let point = CGPoint(x: 99, y: 566)
//        shareButton.center = point
//        self.view.addSubview(shareButton)
        
        super.viewDidLoad()
        publishButton.layer.cornerRadius = 20
        
        self.setupProfilePic()
        loginButton.delegate = self
        
        let numberofentries = EntriesController.sharedInstance.getnumberofEntries()
        numberofEntrieslabel.text = "Number of entries: \(numberofentries)"
        self.changephoto(facebookImage)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        let numberofentries = EntriesController.sharedInstance.getnumberofEntries()
        numberofEntrieslabel.text = "Number of entries: \(numberofentries)"
        
        

    }
    
    func setupProfilePic() {
        profileImageView.layer.borderWidth = 0
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.blackColor().CGColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        profileImageView.image = UIImage(named: "profile")
        print(PersistenceManager.loadObject("profilePic"))
        if let profileImage = PersistenceManager.loadObject("profilePic") as? UIImage {
        profileImageView.image = profileImage
    }
    }
    
    
    @IBAction func publishButtonTapped(sender: UIButton) {
        if (EntriesController.sharedInstance.getnumberofEntries() != 0) {
            
            let numberofentries = EntriesController.sharedInstance.getnumberofEntries()
            let currentDate = NSDate()
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
            let date = dateFormatter.stringFromDate(currentDate)
            let text = ""
            let entries = EntriesController.sharedInstance.getEntries()
            print(date)
            for (pastDate, pastEntry) in entries {
                print(pastDate)
                if pastDate == date {
                    let text = pastEntry.entryText
                    let image = pastEntry.imageofDay
                    var textToShare = ""
                    if numberofentries == 1 {
                        textToShare = "I have made a total of 1 entry in my daily journal Ephemeris. This is my log from today: \(text!)"
                    }
                    else {
                        textToShare = "I have made a total of \(numberofentries) entries in my daily journal Ephemeris. This is my log from today: \(text!)"
                    }
                    
                    let objectsToShare: [AnyObject] = [image!, textToShare]
                    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                    
                    //New Excluded Activities Code
                    activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList, UIActivityTypeAssignToContact]
                    //
                    
                    activityVC.popoverPresentationController?.sourceView = sender
                    self.presentViewController(activityVC, animated: true, completion: nil)
                    break
                }
            }
            
            let alert = UIAlertController(title: "Alert", message: "Cannot publish an empty log. Please tell us what your day was like first.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Canel", style: UIAlertActionStyle.Cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Take me there", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
                
                let newEntryvc = NewEntryViewController(nibName: "NewEntryViewController", bundle: nil)
                self.presentViewController(newEntryvc, animated: true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Alert", message: "Cannot publish an empty log. Please tell us what your day was like first.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Canel", style: UIAlertActionStyle.Cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Take me there", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
                
                let newEntryvc = NewEntryViewController(nibName: "NewEntryViewController", bundle: nil)
                self.presentViewController(newEntryvc, animated: true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        
    }



    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let image = UIImage(named: "profile")
        PersistenceManager.saveObject(image!, fileName: "profilePic")
        appDelegate.navigateToLandingScreen()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func returnButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
  
    
    
    func changephoto(image: UIImage?) {
        if let profilepic = image {
            profileImageView.image = profilepic
        }
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
