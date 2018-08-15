//
//  SingleShotViewController.swift
//  Shots
//
//  Created by user on 06/08/2018.
//  Copyright © 2018 Doug. All rights reserved.
//

import UIKit
import CoreData

class SingleShotViewController: UIViewController {
    
    @IBOutlet weak var cardStats: UILabel!
    @IBOutlet weak var cardText: UILabel!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardType: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    
    var name = ""
    var type = ""
    var imgURL = "http://via.placeholder.com/350x150"
    var stats = ""
    var text = ""
    
    override func viewWillAppear(_ animated: Bool) {
        
        cardText.text = text
        cardName.text = name
        cardType.text = type
        cardStats.text = stats
        
        
        let url = URL(string: imgURL)
        let data = try! Data(contentsOf: url!)
        cardImage.image = UIImage(data: data)
    }

    
    override func viewDidLoad() {
         super.viewDidLoad()
        print(imgURL)

    }
    
    @IBAction func addToDeck(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Cards", in: context)
        let newCard = NSManagedObject(entity: entity!, insertInto: context)
        newCard.setValue(name, forKey: "cardName")
        newCard.setValue(type, forKey: "cardType")
        newCard.setValue(imgURL, forKey: "cardImage")
        
        do {
            try context.save()
        } catch {
            print("Failed saving Card")
        }
        
        performSegue(withIdentifier: "deckSegue", sender: self)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
