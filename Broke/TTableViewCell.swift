//
//  TTableViewCell.swift
//  Broke
//
//  Created by Aritro Paul on 12/05/18.
//  Copyright © 2018 NotACoder. All rights reserved.
//

import UIKit

class TTableViewCell: UITableViewCell {

    @IBOutlet weak var percentageValue: UILabel!
    @IBOutlet weak var percentageView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
