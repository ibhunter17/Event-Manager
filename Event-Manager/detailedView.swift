//
//  detailedView.swift
//  Event-Manager
//
//  Created by Nitish Dang on 2017-07-13.
//  Copyright © 2017 Nitish Dang. All rights reserved.
//

import UIKit

class detailedView: UIViewController {
    var event:Events!
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var eventimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text="Name: "+event.name!
        adress.text="Adress:"+event.adress!
        let dataDecoded : Data = Data(base64Encoded: event.imgData!, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        eventimage.image=decodedimage
        date.text="Date:"+event.date!
        time.text="Time:"+event.time!
        price.text="Price: $"+event.price!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func edit(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EditView") as! EditView
        nextViewController.Event = event
        self.present(nextViewController, animated:true, completion:nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
