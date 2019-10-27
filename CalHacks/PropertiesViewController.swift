//
//  PropertiesViewController.swift
//  CalHacks
//
//  Created by Vasuman Moza on 10/26/19.
//  Copyright © 2019 Yaksh Patel. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PropertiesViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfSectionsInTableView section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let(modelTemp) = models[indexPath.row]
        cell.textLabel?.text = "\(modelTemp.address!)" //String(Int(modelTemp.baths))
        return cell
    }
    
    var ref: DatabaseReference?
    var models : [MySnap] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Hello World")

//
////        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        let secondViewController = segue.destination as! SecondViewController
////
////        // set a variable in the second view controller with the data to pass
////        secondViewController.receivedData = "hello"
////        }
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        ref = Database.database().reference()
                
                ref?.child("1S4XubsXdhp9UJwkpmPswIQKlgN7pl3LRoua15dvdC0A").child("data (1)").observeSingleEvent(of: .value, with: { (snapshot) in

                if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                                for snap in snapshot {
        //                            print("Zhenya: here is the snap: \(snap)")
                                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                                        let key = snap.key
        //                                print(postDict)
                                        var model = MySnap(postDict)
                                        self.models.append(model)
                                    } else {
                                    }
                                }
                            }
                    print(self.models)
                    
                })

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "address") {
//            let vc = segue.destination as! AddressDetailsTableViewController
//            if let mySnap = sender as? MySnap {
//                vc.address = mySnap.address
//
//            }
//        }
//    }

}

extension PropertiesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(models[indexPath.row].address)
        self.performSegue(withIdentifier: "address", sender: models[indexPath.row])
    }
}
