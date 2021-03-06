//
//  ImageItemCell.swift
//  Budget-App
//
//  Created by Joshua Fraser on 3/1/18.
//  Copyright © 2018 Joshua Fraser. All rights reserved.
//

import UIKit


//private let reuseIdentifier = "Cell2"

class ImageItemCell: UICollectionViewCell {
    
    @IBOutlet private weak var dataItemImageView: UIImageView!
    
    var envelopeItem: EnvelopeItem? {
        didSet {
            if let envelopeItem = envelopeItem {
                dataItemImageView.image = UIImage(named: envelopeItem.imageName)
            }
        }
    }
}
