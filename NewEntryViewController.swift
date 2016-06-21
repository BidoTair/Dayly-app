//
//  NewEntryViewController.swift
//  Ephemeris - Daily Journal
//
//  Created by Abdulghafar Al Tair on 6/20/16.
//  Copyright © 2016 Abdulghafar Al Tair. All rights reserved.
//

import UIKit

class NewEntryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
   
    @IBOutlet weak var textView: UITextView!
    
    let imagePicker = UIImagePickerController()
    let imageButton = UIButton(type: .Custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        dateLabel.text = dateFormatter.stringFromDate(currentDate)
        

        
        imageButton.frame = CGRectMake(20.0, 27.0, 334.0, 120.0)
        let defaultimage = UIImage(named: "defaultimage")
        imageButton.contentMode = UIViewContentMode.ScaleAspectFill
        imageButton.layer.borderWidth = 1
        imageButton.clipsToBounds = true
        imageButton.setImage(defaultimage, forState: .Normal)
        imageButton.addTarget(self, action: #selector(self.imageofDayTapped), forControlEvents: .TouchUpInside)
        self.view.addSubview(imageButton)
        
        self.view.subviews[1].layer.borderWidth = 2.3
        self.view.subviews[1].layer.borderColor = UIColor.brownColor().CGColor
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        backgroundImage.addSubview(blurEffectView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func submitButtonTapped(sender: UIButton) {
        
        if textView.text == "" {
            
            let alert = UIAlertController(title: "Alert", message: "Are you sure you want to submit an empty entry?", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
                EntriesController.sharedInstance.addEntry(self.textView.text, imageofDay: self.imageButton.imageView?.image, backgroundimage: self.backgroundImage.image, date: self.dateLabel.text)
            }))
            
                        
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        else {
        EntriesController.sharedInstance.addEntry(textView.text, imageofDay: imageButton.imageView?.image, backgroundimage: backgroundImage.image, date: dateLabel.text)
        }
        
    }
    

    func imageofDayTapped() {
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        backgroundImage.image = image
        imageButton.setImage(image, forState: .Normal)
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
