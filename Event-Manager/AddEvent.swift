//
//  AddEvent.swift
//  Event-Manager
//
//  Created by Nitish Dang on 2017-07-13.
//  Copyright © 2017 Nitish Dang. All rights reserved.
//

import UIKit
import  FirebaseStorage
import Firebase
class AddEvent: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var ref: DatabaseReference!
    var date:String=""
    var time:String=""
    var mainimage:UIImage!
    var data:String!
    var imageDataString=""
    var strBase64:String=""
    @IBOutlet weak var EventAdress: UITextField!
    @IBOutlet weak var EventPrice: UITextField!
    @IBOutlet weak var EventName: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet weak var previewImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func libraryPicture(_ sender: Any) {
        let image=UIImagePickerController()
        image.delegate=self
        image.sourceType=UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing=false
        self.present(image,animated:true)
        {
            //After it is complete
        }
        
    }
    @IBAction func pickerValueChanged(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat="MMMM dd, YYYY"
        date=formatter.string(from: datePicker.date)
        formatter.dateFormat="hh:mm a"
        time=formatter.string(from: datePicker.date)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            mainimage = image
            previewImage.image=image
            let compression = 0.9
        let imageData:Data=UIImageJPEGRepresentation(image,CGFloat(compression))!
        strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        }
        else {
            print("No picture")
        }
        self.dismiss(animated: true, completion: nil)
     }
    
    @IBAction func AddEvent(_ sender: Any) {
        let newEvent = [
            "Name":self.EventName.text!,
            "Adress":self.EventAdress.text!,
            "Price":self.EventPrice.text!,
            "Date":self.date,
            "Time":self.time,
            "imgData":self.strBase64
        ]
        let ref=Database.database().reference()
        let name=EventName.text!
        let database=ref.child("Events").child(name)
        print(name)
     database.updateChildValues(newEvent)
     EventName.text=""
     EventAdress.text=""
     EventPrice.text = ""
    }
}
