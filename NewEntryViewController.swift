//
//  NewEntryViewController.swift
//  Ephemeris - Daily Journal
//
//  Created by Abdulghafar Al Tair on 6/20/16.
//  Copyright © 2016 Abdulghafar Al Tair. All rights reserved.
//

import UIKit
import TextAttributes

class NewEntryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var smallerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var imageOfButton: UIImageView!
    
    let imagePicker = UIImagePickerController()
    let imageButton = UIButton(type: .Custom)
    
    var editMode: Bool = false
    var sentDatefrommain: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        dateLabel.text = dateFormatter.stringFromDate(currentDate)
        
        
        
        imageButton.frame = CGRectMake(20, 37, self.smallerView.frame.size.width, 120.0)
        imageButton.backgroundColor = UIColor.clearColor()
        imageButton.layer.borderWidth = 2.3
        imageButton.layer.borderColor = UIColor.brownColor().CGColor
        imageButton.layer.cornerRadius = 20
        imageOfButton.layer.cornerRadius = 20
        imageButton.addTarget(self, action: #selector(self.imageofDayTapped), forControlEvents: .TouchUpInside)
        imageButton.clipsToBounds = true
        
        let defaultimage = UIImage(named: "defaultimage")
        imageOfButton.image = defaultimage
        imageOfButton.bounds = imageButton.frame
        imageOfButton.clipsToBounds = true

        
        
//        imageButton.contentVerticalAlignment = .Fill
//        imageButton.contentHorizontalAlignment = .Fill
        
//        imageButton.imageView?.bounds = CGRectMake(0.0, 0.0, 134.0, 134.0)
//        imageButton.imageView?.clipsToBounds = false
//        imageButton.imageView?.contentMode = .ScaleAspectFill
        
//        imageButton.imageView?.frame = CGRectMake(20.0, 27.0, 334.0, 120.0)
//        imageButton.imageView?.bounds = CGRect(x: 0.0, y: 0.0, width: 334.0, height: 334.0)
//        imageButton.imageView?.contentMode = .ScaleAspectFit
//        imageButton.imageView?.clipsToBounds = false
        
        
        self.view.addSubview(imageButton)
        
        
        
        
        smallerView.layer.borderWidth = 2.3
        smallerView.layer.cornerRadius = 20
        smallerView.layer.borderColor = UIColor.brownColor().CGColor
        textView.layer.cornerRadius = 20
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        backgroundImage.addSubview(blurEffectView)
        
        
        
        if editMode {
            self.editEntry(sentDatefrommain!)
            textView.userInteractionEnabled = false
            imageButton.userInteractionEnabled = false
            submitButton.setTitle("Edit Entry", forState: UIControlState.Normal)
        }
        
        
//        
//        let attrs: TextAttributes = TextAttributes()
//            .foregroundColor(white: 0.1, alpha: 1)
//            .font(name: "Avenir", size: 15)
//            .lineHeightMultiple(1.2)
//            .paragraphSpacing(18)
//           
//        
//        textView.attributedText = NSMutableAttributedString(string: textView.text, attributes: attrs)
    
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(self.presentImage))
        self.imageButton.addGestureRecognizer(longpress)
        
        let swipedown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "dismissKeyboard")
        swipedown.direction = UISwipeGestureRecognizerDirection.Down
        swipedown.numberOfTouchesRequired = 1
        textView.addGestureRecognizer(swipedown)
        view.addGestureRecognizer(swipedown)

    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
 
    
    func presentImage() {
        let ivc = ImageofDayViewController(nibName: "ImageofDayViewController", bundle: nil)
      // ivc.view.backgroundColor = UIColor.clearColor()
        ivc.image = imageOfButton.image
        self.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        self.presentViewController(ivc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    @IBAction func submitButtonTapped(sender: UIButton) {
        if editMode {
            textView.userInteractionEnabled = true
            imageButton.userInteractionEnabled = true
            submitButton.setTitle("Submit Entry", forState: .Normal)
            editMode = false
        }
        else {
            
            if textView.text == "" {
                
                let alert = UIAlertController(title: "Alert", message: "Are you sure you want to submit an empty entry?", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
                    EntriesController.sharedInstance.addEntry(self.textView.text, imageofDay: self.imageOfButton.image, backgroundimage: self.backgroundImage.image, date: self.dateLabel.text)
                }))
                
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            else {
                EntriesController.sharedInstance.addEntry(textView.text, imageofDay: imageOfButton.image, backgroundimage: backgroundImage.image, date: dateLabel.text)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    func editEntry(date: String) {
        print(date)
        if( EntriesController.sharedInstance.getnumberofEntries() == 0) {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
            dateLabel.text = date
            let defaultimage = UIImage(named: "defaultimage")
            imageOfButton.image = defaultimage
            textView.text = ""
        }
        else {
            let entries = EntriesController.sharedInstance.getEntries()
            for (pastDate, pastEntry) in entries {
                //print(pastDate)
                if pastDate == date {
                    print(pastEntry.entryText)
                    self.dateLabel.text = date
                    self.imageOfButton.image = pastEntry.imageofDay
                    self.textView.text = pastEntry.entryText
                    self.backgroundImage.image = pastEntry.backgroudImage
                    break
                }
                else {
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
                    dateLabel.text = date
                    let defaultimage = UIImage(named: "defaultimage")
                    imageOfButton.image = defaultimage
                    textView.text = ""
                    //backgroundimage
                }
            }
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
        imageOfButton.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
