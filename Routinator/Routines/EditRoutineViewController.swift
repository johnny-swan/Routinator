//
//  EditRoutineViewController.swift
//  Routinator
//
//  Created by Ivan Lebed on 16/11/2023.
//

import UIKit

class EditRoutineViewController: UIViewController {

    @IBOutlet weak var taskTable: UITableView!
    var currentRoutine: Routine?
    let manager = ChoresDataManager(routine: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTable.dataSource = self
        manager.routine = currentRoutine
        
        manager.fetch()
    }
    
}


// MARK: TableViewDataSource
extension EditRoutineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath ) as! EditableChoreCell
        let chore = manager.chore(at: indexPath)
        
        cell.lblCaption!.text = chore.name
        cell.lblDescription!.text = chore.desc
        cell.dpStartTime!.setDate(chore.timeStartValue!, animated: true)
        cell.dpDuration!.setDate(chore.timeStartValue!.addingTimeInterval(TimeInterval(60*chore.duration!)), animated: true)
        
//        cell.pvDuration!
//        cell.chore = chore

        return cell
    }
    
    
}
// MARK: TabelViewDelegate


