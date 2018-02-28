//
//  EnvItemCell.swift
//  Budget-App
//
//  Created by Joshua Fraser on 2/7/18.
//  Copyright © 2018 Joshua Fraser. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class EnvItemCell: UICollectionViewCell {
    
    @IBOutlet private weak var dataItemImageView: UIImageView!
    @IBOutlet weak var dataItemTextView: UITextField!
    
    var envelopeItem: Envelope? {
        didSet {
            if let envelopeItem = envelopeItem {
                dataItemImageView.image = UIImage(named: envelopeItem.image!)
                dataItemTextView.text = envelopeItem.name
            }
        }
    }
}
