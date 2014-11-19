//
//  PersonTableViewCell.swift
//  iOSFoundationsRoster
//
//  Created by Alexandra Norcross on 11/18/14.
//  Copyright (c) 2014 Alexandra Norcross. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    //Cell image: Person's image
    @IBOutlet weak var imagePerson: UIImageView!
    
    //Cell label: Person's name
    @IBOutlet weak var labelPersonName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
