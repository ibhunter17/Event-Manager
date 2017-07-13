//
//  ViewController.swift
//  Event-Manager
//
//  Created by Nitish Dang on 2017-07-13.
//  Copyright © 2017 Nitish Dang. All rights reserved.
//

import UIKit
import  FirebaseStorage
import Firebase
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var refHandler:UInt!
    var ref:DatabaseReference!
    var EventList = [Events]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        GetEvents()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "procell", for: indexPath) as! CustomCelTableViewCell
        cell.eventName.text=EventList[indexPath.row].name!
        cell.eventDate.text=EventList[indexPath.row].date!
        let dataDecoded : Data = Data(base64Encoded: EventList[indexPath.row].imgData!, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        cell.eventPicture.image=decodedimage
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
      let nextViewController = storyBoard.instantiateViewController(withIdentifier: "detailedView") as! detailedView
      nextViewController.event=EventList[indexPath.row]
     self.present(nextViewController, animated:true, completion:nil)
    }
    func GetEvents (){
        ref=Database.database().reference()
        refHandler=ref.child("Events").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let event=Events()
                event.setValuesForKeys(dictionary)
                self.EventList.append(event)
            }
            else {
                print("event not there")
            }
        self.tableView.reloadData()
        })
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        ref=Database.database().reference()
        let event2=EventList[indexPath.row]
        let name=event2.name!
        let database=ref.child("Events").child(name)
        if editingStyle == .delete{
            database.removeValue()
            EventList.remove(at: indexPath.row)
             self.tableView.reloadData()
        }
      }


}

