//
//  EmployeeTVCell.swift
//  CoreDBLearning
//
//  Created by prashant on 30/12/22.
//

import UIKit

class EmployeeTVCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePhotoImgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
