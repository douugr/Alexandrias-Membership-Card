//
//  ViewController.swift
//  Shots
//
//  Created by user on 06/08/2018.
//  Copyright © 2018 Doug. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var eachCard:[String:Any] = [String:Any]()
    var cardsArray:[[String:Any]] = [[String: Any]]()
    var cardColors:NSArray = []
    var imageUrl = URL(string: "")
    var imageData = Data()
    
    var queryName = ""
    var queryType = ""
    var querySet = ""
    var queryColors = ""
    var queryCMC = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(queryType)
        print(queryName)
        print(queryCMC)
        
        tableView.dataSource = self
        tableView.delegate = self
        let nibName = UINib(nibName: "CardTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardCell")
        
        apiRequest()
    }
    
    func apiRequest() {
        Alamofire.request("https://api.magicthegathering.io/v1/cards?name=\(queryName)&type=\(queryType)&set=\(querySet)&colors=\(queryColors)&cmc=\(queryCMC)").responseJSON { response in
            
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseCards = responseValue["cards"] as! [[String: Any]]? {
                    self.cardsArray = responseCards
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cardsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell") as! CardTableViewCell
        
        self.eachCard = cardsArray[indexPath.row]
        var url:String = ""
        cell.cardName.text = eachCard["name"] as? String
        cell.cardType.text = eachCard["type"] as? String
        if eachCard["imageUrl"] == nil {
            url = "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=375653&type=card"
        } else {
            url = (eachCard["imageUrl"] as? String)!
        }
        cell.cardImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder"))
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.dequeueReusableCell(withIdentifier: "CardCell") as! CardTableViewCell?
        self.eachCard = cardsArray[indexPath.row]

        self.performSegue(withIdentifier: "showCard", sender: tableView)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let card = segue.destination as? SingleShotViewController
        if segue.identifier == "showCard" {
            card?.name = eachCard["name"] as! String
            card?.type = eachCard["type"] as! String
            if eachCard["imageUrl"] == nil {
                card?.imgURL = "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=264373&type=card"
            } else {
            card?.imgURL = eachCard["imageUrl"] as! String
            }
            if eachCard["text"] == nil {
                card?.text = ""
            }
        }
    }
    
    

}

