//
//  EditableChoreCell.swift
//  Routinator
//
//  Created by Ivan Lebed on 20/11/2023.
//

import UIKit
protocol EditableChoreCellDelegate: AnyObject {
    func startTimeChanged(_ cell: EditableChoreCell, date: TimeStamp)
    func durationChanged(_ cell: EditableChoreCell, date: TimeStamp)
}

class EditableChoreCell: UITableViewCell {

    @IBOutlet weak var lblCaption: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var dpStartTime: UIDatePicker!    
    @IBOutlet weak var dpDuration: UIDatePicker!
    
    weak var delegate: EditableChoreCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Add targets for date picker value change events
        dpStartTime.addTarget(self, action: #selector(startTimeChanged(_ :)), for: .editingDidEnd)
        dpDuration.addTarget(self, action: #selector(durationChanged(_ :)), for: .editingDidEnd)

    }
    

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    @objc func startTimeChanged(_ sender: UIDatePicker) {
        delegate?.startTimeChanged(self, date: TimeStamp(fromDate: dpStartTime.date))
    }
    
    @objc func durationChanged(_ sender: UIDatePicker) {
        delegate?.durationChanged(self, date: TimeStamp(fromDate: dpDuration.date))
    }
}
