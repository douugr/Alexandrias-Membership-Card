//
//  CardCollectionViewCell.swift
//  Shots
//
//  Created by user on 13/08/2018.
//  Copyright © 2018 Doug. All rights reserved.
//

import UIKit

protocol CardCollectionProtocol {
    
    func deleteData(indx: Int)
}

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardType: UILabel!
    
    var delegate:CardCollectionProtocol?
    var index: IndexPath?

    @IBAction func deleteItem(_ sender: Any) {
        delegate?.deleteData(indx: (index?.row)!)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
