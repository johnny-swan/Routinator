//
//  RoutineTableViewController.swift
//  Routinator
//
//  Created by Ivan Lebed on 12/11/2023.
//

import UIKit

class RoutineTableViewController: UIViewController {
    @IBOutlet weak var routineTable: UITableView!
    let manager = RoutineDataManager()
    var selectedRoutine: Routine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        routineTable.dataSource = self
        routineTable.delegate = self

        manager.fetch()
        print("got \(manager.numberOfItems()) routines")
        // Do any additional setup after loading the view.
        initUI()
    }
    func initUI() {
    }
    
    @IBAction func unwindAddRoutineSegue(segue: UIStoryboardSegue) {
        print("segue: \(segue.identifier)")
    }

    @IBAction func unwindAddRoutineDone(segue: UIStoryboardSegue) {
       
    }
    func addRoutine(_ routine: Routine) {
        print("I will add new routine with name = \(routine.name!)")
        manager.addRoutine(routine)
        routineTable.reloadData()
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("preparing for segue: \(segue.identifier)")
        print("segue destination: \(segue.destination)")
        print(segue.destination is EditRoutineViewController)
        print(selectedRoutine ?? "govno")
        if let editController = segue.destination as? EditRoutineViewController,
           let routine = selectedRoutine {
            editController.currentRoutine = routine
            print("set current routine as \(routine.name!)")
        } else {
            print("Something goes wrong")
        }
    }

}
// MARK: UITableViewDataSource
extension RoutineTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoutineCell", for: indexPath)
        cell.textLabel!.text = "\(manager.routine(at: indexPath).name ?? "...")"
        return cell
    }
    
    
    
}
// MARK: UITableViewDataSource
extension RoutineTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRoutine = manager.routine(at: indexPath)
        performSegue(withIdentifier: "openEditRoutine", sender: nil)
    }
}
