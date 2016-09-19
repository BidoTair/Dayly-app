//
//  MainScreenViewController.swift
//  Ephemeris - Daily Journal
//
//  Created by Abdulghafar Al Tair on 6/20/16.
//  Copyright © 2016 Abdulghafar Al Tair. All rights reserved.
//

import UIKit
import CalendarView
import FBSDKLoginKit
import SwiftMoment





class MainScreenViewController: UIViewController, CalendarViewDelegate {
    
    let button  = UIButton(type: .Custom)
    
    @IBOutlet weak var scrollView: UIScrollView!
   
    @IBOutlet weak var calendar: CalendarView!
    var name: String?
    
    var alreadyWritten: Bool = false
    
    let welcomeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar()
        self.setupCalendar()
        calendar.delegate = self
        self.returnUserData()
        self.scrollView.frame = CGRectMake(0, 44, self.view.frame.width, 304)
        welcomeLabel.frame =  CGRectMake(62, 155, self.view.frame.width, 120)
        self.setupScroll()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.setupScroll()
        self.setupCalendar()
        self.setupNavBar()
        self.scrollView.addSubview(welcomeLabel)
        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = "MMMM d, yyyy"
        title = dateformatter.stringFromDate(NSDate())
        
        if let profilePic = PersistenceManager.loadObject("facebookprofilePic") as? UIImage {
        button.setImage(profilePic, forState: .Normal)
        }
        
       // self.navigationController!.navigationBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 80.0)

    }
    
    override func viewDidAppear(animated: Bool) {
         self.navigationController!.navigationBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 80.0)
       // self.navigationController?.navigationBar.tintColor = UIColor.clearColor()
       
    }
    
    func setupScroll() {
        
        let scrollViewWidth = self.scrollView.frame.width
        let scrollViewHeight = self.scrollView.frame.height
        print(scrollViewHeight)
        
        let entries = EntriesController.sharedInstance.getEntries()
        let numberofentries = CGFloat(EntriesController.sharedInstance.getnumberofEntries())
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width*numberofentries, self.scrollView.frame.height)
        
        welcomeLabel.textColor = UIColor.init(red: 43/255.0, green: 118/255.0, blue: 135/255.0, alpha: 0.6)
        welcomeLabel.font = UIFont(name: "Helvetica Neue", size: 35)
        welcomeLabel.numberOfLines = 3
        
        
        
        
        
    var f = CGFloat(0)
        
        for (_, pastEntry) in entries {
            let imageScrollView = UIImageView(frame: CGRectMake(scrollViewWidth*f, 44, scrollViewWidth, 367))
            imageScrollView.image = pastEntry.imageofDay
            // imageScrollView.contentMode = .ScaleAspectFit
            self.scrollView.addSubview(imageScrollView)
            f += CGFloat(1)
        }
        
    }
    
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                
                if let id: NSString = result.valueForKey("id") as? NSString {
                    print("ID is: \(id)")
                    self.returnUserProfileImage(id)
                } else {
                    print("ID es null")
                }
                
                if let facebookName = result.valueForKey("name") as? NSString {
                    self.name = facebookName as String
                    self.welcomeLabel.text = "Welcome back, \(self.name!)"
                    self.welcomeLabel.textColor = UIColor.init(red: 43/255.0, green: 118/255.0, blue: 135/255.0, alpha: 0.6)
                    print(self.welcomeLabel.text)
                    self.scrollView.addSubview(self.welcomeLabel)
                }
                
                
            }
        })
    }
    
    func returnUserProfileImage(accessToken: NSString)
    {
        let userID = accessToken as NSString
        let facebookProfileUrl = NSURL(string: "https://graph.facebook.com/\(userID)/picture?type=large")
        
        if let data = NSData(contentsOfURL: facebookProfileUrl!) {
            let image = UIImage(data: data)
            button.setImage(image, forState: .Normal)
            PersistenceManager.saveObject(image!, fileName: "facebookprofilePic")
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupCalendar() {
        CalendarView.daySelectedTextColor = UIColor.whiteColor()
        CalendarView.dayBackgroundColor = UIColor.init(red: 161/255.0, green: 159/255.0, blue: 134/255.0, alpha: 1)
        CalendarView.dayTextColor = UIColor.whiteColor()
        CalendarView.otherMonthTextColor = UIColor.init(red: 43/255.0, green: 118/255.0, blue: 135/255.0, alpha: 1)
        CalendarView.weekLabelTextColor = UIColor.init(red: 43/255.0, green: 118/255.0, blue: 135/255.0, alpha: 1)
    }
    
    func calendarDidSelectDate(date: Moment) {
        
        title = date.format("MMMM d, yyyy")
        let sentDate = date.format("EEEE, MMMM dd, yyyy")
        
        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        let currentDateString = dateFormatter.stringFromDate(currentDate)
        
        let editEntryvc = NewEntryViewController(nibName: "NewEntryViewController", bundle: nil)
        editEntryvc.sentDatefrommain = sentDate
        editEntryvc.editMode = true
        
        if (sentDate == currentDateString) {
            CalendarView.daySelectedBackgroundColor = UIColor.init(red: 43/255.0, green: 118/255.0, blue: 135/255.0, alpha: 1)
        }
        else {
            CalendarView.daySelectedBackgroundColor = UIColor.init(red: 161/255.0, green: 159/255.0, blue: 134/255.0, alpha: 1)
        }
        CalendarView.todayBackgroundColor = UIColor.init(red: 43/255.0, green: 118/255.0, blue: 135/255.0, alpha: 1)
        CalendarView.daySelectedTextColor = UIColor.whiteColor()
        
        self.presentViewController(editEntryvc, animated: true, completion: nil)
    }
    
   
    
    func calendarDidPageToDate(date: Moment) {
        //
    }
    
    func setupNavBar() {
        
        
        
        let otherbutton  = UIButton(type: .Custom)
        let otherimage = UIImage(named: "Plus")
        otherbutton.setImage(otherimage, forState: .Normal)
        otherbutton.frame = CGRectMake(600.0, 600.0, 47.0, 47.0)
        otherbutton.layer.cornerRadius = otherbutton.frame.height/2
        otherbutton.contentMode = UIViewContentMode.ScaleAspectFill
        otherbutton.layer.borderWidth = 1
        otherbutton.clipsToBounds = true
        otherbutton.addTarget(self, action: #selector(self.presentNewEntryViewController), forControlEvents: .TouchUpInside)
        
        let plusButton = UIBarButtonItem(customView: otherbutton)
        self.navigationItem.setRightBarButtonItem(plusButton, animated: true)
        
        
        let image = UIImage(named: "profile")
        button.setImage(image, forState: .Normal)
        button.frame = CGRectMake(0.0, 0.0, 47.0, 47.0)
        button.layer.cornerRadius = button.frame.height/2
        button.contentMode = UIViewContentMode.ScaleAspectFill
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.presentProfileViewController), forControlEvents: .TouchUpInside)
        
        let profileButton = UIBarButtonItem(customView: button)
        self.navigationItem.setLeftBarButtonItem(profileButton, animated: true)
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        // Sets shadow (line below the bar) to a blank image
        self.navigationController?.navigationBar.shadowImage = UIImage()
        // Sets the translucent background color
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        // Set translucent. (Default value is already true, so this can be removed if desired.)
        UINavigationBar.appearance().translucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.init(red: 43/255.0, green: 118/255.0, blue: 135/255.0, alpha: 1)]
    }
    
    func presentNewEntryViewController() {
        if alreadyWritten {
            self.presentEditEntryViewController()
        }
        else {
            self.alreadyWritten = true
        let newEntryvc = NewEntryViewController(nibName: "NewEntryViewController", bundle: nil)
        self.presentViewController(newEntryvc, animated: true, completion: nil)
        }
    }
    
    func presentEditEntryViewController() {
        let editEntryvc = NewEntryViewController(nibName: "NewEntryViewController", bundle: nil)
        let dateformatter = NSDateFormatter()
        let currentdate = NSDate()
        dateformatter.dateFormat = "EEEE, MMMM dd, yyyy"
        let date = dateformatter.stringFromDate(currentdate)
        editEntryvc.sentDatefrommain = date

        editEntryvc.editMode = true
        self.presentViewController(editEntryvc, animated: true, completion: nil)
    }
    
    func presentProfileViewController() {
        let pvc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        pvc.facebookImage = button.imageView?.image
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
