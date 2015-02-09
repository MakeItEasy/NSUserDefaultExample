//
//  ViewController.swift
//  NSUserDefaultExample
//
//  Created by moyan on 15-2-9.
//  Copyright (c) 2015年 moyan. All rights reserved.
//

// http://code.tutsplus.com/tutorials/ios-sdk-working-with-nsuserdefaults--mobile-6039

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var imgAvatar: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadUserSettings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func imgPickerTapped(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(picker, animated: true, completion: nil)
        
    }

    @IBAction func btnSaveTapped(sender: AnyObject) {
        // Hide the keyboard
        txtUsername.resignFirstResponder()
        txtPassword.resignFirstResponder()
        txtAge.resignFirstResponder()
        
        let imageData = UIImageJPEGRepresentation(imgAvatar.image, 100)
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setValue(txtUsername.text, forKey: "username")
        userDefault.setValue(txtPassword.text, forKey: "password")
        userDefault.setValue(txtAge.text.toInt(), forKey: "age")
        userDefault.setObject(imageData, forKey: "avatar")
        userDefault.synchronize()
        NSLog("Data saved")
    }
    
    // # Mark
    // Picker Controller Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        self.imgAvatar.image = info[UIImagePickerControllerEditedImage] as UIImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // private
    private func loadUserSettings() {
        let userDefault = NSUserDefaults.standardUserDefaults()
        txtUsername.text = userDefault.stringForKey("username")
        txtPassword.text = userDefault.stringForKey("password")
        txtAge.text = userDefault.integerForKey("age").description
        let imageData = userDefault.dataForKey("avatar")
        if imageData != nil {
            imgAvatar.image = UIImage(data: imageData!)
        }
    }
}

