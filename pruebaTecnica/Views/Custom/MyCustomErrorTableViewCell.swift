//
//  MyCustomErrorTableViewCell.swift
//  pruebaTecnica
//
//  Created by Nestor Cortés on 02-01-22.
//

import UIKit

class MyCustomErrorTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
