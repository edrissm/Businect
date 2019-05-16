//
//  ViewControllerTableViewCell.swift
//  Businect
//
//  Created by nina erlacher on 16.05.19.
//  Copyright © 2019 Scrum-Made. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var lblVorname: UILabel!
    @IBOutlet weak var lblBeruf: UILabel!
    @IBOutlet weak var lblBranche: UILabel!
    @IBOutlet weak var lblEMail: UILabel!
    @IBOutlet weak var lblInteresse1: UILabel!
    @IBOutlet weak var lblInteresse2: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPasswort: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
