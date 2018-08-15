//
//  CardsCollectionViewController.swift
//  Shots
//
//  Created by user on 13/08/2018.
//  Copyright © 2018 Doug. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

class CardsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var cardsView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cards")
    var results:NSArray = NSArray()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var result:[Any] = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nibName = UINib(nibName: "CardCollectionViewCell", bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "cardItem")
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let context = appDelegate.persistentContainer.viewContext
        request.returnsObjectsAsFaults = false
        results = try! context.fetch(request) as NSArray
        request.returnsObjectsAsFaults = false
        do {
            self.result = try context.fetch(request)
            collectionView.reloadData()
        } catch {
            print("Failed")
        }
        return result.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardItem", for: indexPath) as! CardCollectionViewCell
        
        let res = results[indexPath.row] as! NSManagedObject
        cell.cardName.text = res.value(forKey: "cardName") as? String
        cell.cardType.text = res.value(forKey: "cardType") as? String
        if res.value(forKey: "cardImage") == nil {
     
        }
        cell.cardImage.sd_setImage(with: URL(string: (res.value(forKey: "cardImage") as? String)!), placeholderImage: UIImage(named: "placeholder"))

        cell.index = indexPath
        cell.delegate = self
        return cell
    }

}

extension CardsCollectionViewController: CardCollectionProtocol {
    func deleteData(indx: Int) {
        let res = result[indx]
        let context = appDelegate.persistentContainer.viewContext
        if let resultado = try? context.fetch(request) {
            for _ in resultado {
                context.delete(res as! NSManagedObject)
            }
            result.remove(at: indx)
            do {
                try context.save() // <- remember to put this :)
            } catch {
                print("error")
            }
        }


        collectionView.reloadData()
        print(indx)
    }
    
    
    
}
