//
//  EditableChoreCell.swift
//  Routinator
//
//  Created by Ivan Lebed on 20/11/2023.
//

import UIKit

class EditableChoreCell: UITableViewCell {

    @IBOutlet weak var lblCaption: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var dpStartTime: UIDatePicker!    
    @IBOutlet weak var dpDuration: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
