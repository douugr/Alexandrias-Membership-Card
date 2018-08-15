//
//  SearchViewController.swift
//  Shots
//
//  Created by user on 15/08/2018.
//  Copyright © 2018 Doug. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var whiteSwitch: UISwitch!
    @IBOutlet weak var blueSwitch: UISwitch!
    @IBOutlet weak var blackSwitch: UISwitch!
    @IBOutlet weak var redSwitch: UISwitch!
    @IBOutlet weak var greenSwitch: UISwitch!
    
    @IBOutlet weak var cardNameText: UITextField!
    @IBOutlet weak var cardTypeText: UITextField!
    @IBOutlet weak var cardCMCText: UITextField!
    
    var sets:[[String:Any]] = [[String:Any]]()
    var set = ""

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sets.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let setsName = sets[row]
        
        return setsName["name"] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         let setsName = sets[row]
         set = (setsName["code"] as? String)!
    }
    
    
    
    
    override func viewDidLoad() {
        
        Alamofire.request("https://api.magicthegathering.io/v1/sets").responseJSON { response in
            
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseCards = responseValue["sets"] as! [[String: Any]]? {
                        self.sets = responseCards
                }
                
            }
            self.pickerView.reloadAllComponents()
        }
        
        super.viewDidLoad()
        cardNameText.text = ""
        cardCMCText.text = ""
        cardTypeText.text = ""
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let table = segue.destination as! ViewController
        
        if whiteSwitch.isOn {
            table.queryColors.append("white,")
        }
        if blackSwitch.isOn {
            table.queryColors.append("black,")
        }
        if blueSwitch.isOn {
            table.queryColors.append("blue,")
        }
        if redSwitch.isOn {
            table.queryColors.append("red,")
        }
        if greenSwitch.isOn {
            table.queryColors.append("green,")
        }
            table.querySet = set
            table.queryName = cardNameText.text!
            table.queryType = cardTypeText.text!
            table.queryCMC = cardCMCText.text!
        
    }
    



}
