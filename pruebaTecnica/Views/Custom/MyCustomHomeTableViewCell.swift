//
//  MyCustomHomeTableViewCell.swift
//  pruebaTecnica
//
//  Created by Nestor Cortés on 02-01-22.
//

import UIKit

class MyCustomHomeTableViewCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblAdress: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
