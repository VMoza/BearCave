//
//  ViewController.swift
//  CalHacks
//
//  Created by Yaksh Patel on 10/26/19.
//  Copyright © 2019 Yaksh Patel. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        TableView.delegate = self as? UITableViewDelegate
//        TableView.dataSource = self as? UITableViewDataSource
        
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return 100
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            <#code#>
//        }
//
//        func numberOfSections(in tableView: UITableView) -> Int {
//            return 6
//        }
        
        // Do any additional setup after loading the view.
        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "BEARCAVE", attributes:[
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 23.0, weight: UIFont.Weight.light)])
        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
        navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    var selected:bearType = .price
    @IBOutlet weak var PickerView: UIPickerView!
    
    
    
    @IBOutlet weak var LocationText: UIButton!
    @IBOutlet weak var TermText: UIButton!
    @IBOutlet weak var BedBathText: UIButton!
    @IBOutlet weak var PriceText: UIButton!
    
    @IBAction func LocationButton(_ sender: Any) {
        self.selected = .location
        self.PickerView.reloadAllComponents()
    }
    
    @IBAction func TermButton(_ sender: Any) {
        self.selected = .term
        self.PickerView.reloadAllComponents()
    }
    
    @IBAction func BedBathButton(_ sender: Any) {
        self.selected = .bed
        self.PickerView.reloadAllComponents()
    }
    
    @IBAction func PriceButton(_ sender: Any) {
        self.selected = .price
        self.PickerView.reloadAllComponents()
    }
    let locations = ["Northside", "Southside"]
    let terms = ["Spring 2019", "Fall 2020", "Spring 2020"]
    let bedbath = ["1 Bed, 1 Bath", "1 Bed 2 Bath", "2 Bed, 1 Bath", "2 Bed, 2 Bath"]
    let prices = ["$500-1000", "$1000-1500", "$1500-2000"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch (selected) {
        case .term:
            return terms[row]
        case .bed:
            return bedbath[row]
        case .price:
            return prices[row]
        case .location:
            return locations[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch (selected) {
        case .term:
            return terms.count
        case .bed:
            return bedbath.count
        case .price:
            return prices.count
        case .location:
            return locations.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (selected) {
        case .term:
        TermText.setTitle(terms[row], for: .normal)
        case .bed:
            BedBathText.setTitle(bedbath[row], for: .normal)
        case .price:
            PriceText.setTitle(prices[row], for: .normal)
        case .location:
            LocationText.setTitle(locations[row], for: .normal)
        }
    }
    
    

    
    
//    @IBOutlet weak var LocationText: UIButton!
//    @IBOutlet weak var TermText: UIButton!
//    @IBOutlet weak var BedBathText: UIButton!
//    @IBOutlet weak var PriceText: UIButton!

    enum bearType {
        case location
        case term
        case bed
        case price
    }
}

struct MySnap {
    var baths: Int!
    var beds: Int!
    var cost: Int!
    var id: Int!
    var neighborhood: String!
    var term: String!
    var year: Int!
    var address: String!
    
    init(_ myDict:[String:Any]) {
        self.baths = myDict["baths"] as? Int
        self.beds = myDict["beds"] as? Int
        self.cost = myDict["cost"] as? Int
        self.id = myDict["id"] as? Int
        self.neighborhood = myDict["neighborhood"] as! String?
        self.term = myDict["term"] as! String?
        self.year = myDict["year"] as? Int
        self.address = myDict["address"] as! String?
    }
}
