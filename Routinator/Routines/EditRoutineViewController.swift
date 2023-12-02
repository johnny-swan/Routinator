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
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
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
        cell.delegate = self
        cell.lblCaption!.text = chore.name
        cell.lblDescription!.text = chore.desc
        cell.dpStartTime!.setDate(chore.timeStart!.toDate(), animated: true)
       
        cell.dpDuration!.setDate(chore.duration!.toDate(), animated: true)

        return cell
    }
    
    
}
// MARK: TabelViewDelegate

// MARK: EditableChoreCellDelegate

extension EditRoutineViewController: EditableChoreCellDelegate {
    
    func getNewChore(from cell: EditableChoreCell) -> Chore {
        return Chore(
            name: cell.lblCaption!.text ?? "defaultChoreName",
            desc: cell.lblDescription!.text ?? "",
            timeStart: TimeStamp(fromDate: cell.dpStartTime.date),
            duration: TimeStamp(fromDate: cell.dpDuration.date)
        )
    }
    
    func startTimeChanged(_ cell: EditableChoreCell, date: TimeStamp) {
        // find index

        let indexPath = taskTable.indexPath(for: cell)
        // create new chore from cell
        let updatedChore = getNewChore(from: cell)
        // let manager to change data in items
        if let indexPath = indexPath {
            manager.updateChore(at: indexPath, with: updatedChore)
            
        }
    }
    
    func durationChanged(_ cell: EditableChoreCell, date: TimeStamp) {
        print("duration time changed in cell")
        print(cell)
    }
    
    
}
