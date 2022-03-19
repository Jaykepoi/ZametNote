//
//  CustomTableViewCell.swift
//  Notes
//
//  Created by Mikhail Kim on 07.11.2021.
//

import UIKit
import SwipeCellKit

class CustomTableViewCell: SwipeTableViewCell {
    @IBOutlet weak var inView: UIView!
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        inView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
