//
//  AddRoutineViewController.swift
//  Routinator
//
//  Created by Ivan Lebed on 14/11/2023.
//

import UIKit

class AddRoutineViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tfRoutineName: UITextField!
    var weekdays: Array<String> = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? RoutineTableViewController {
            let newRoutine = Routine()
            newRoutine.name = tfRoutineName.text
            
            viewController.addRoutine(newRoutine)
        }
    }
    
    let days = Calendar(identifier: .gregorian).standaloneWeekdaySymbols
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tfRoutineName.delegate = self
        prepareData()
        

        // Do any additional setup after loading the view.
    }
    
    func prepareData() {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_UK")
        weekdays = calendar.weekdaySymbols
    }

}

// MARK: table view data source
extension AddRoutineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekday", for: indexPath)
        cell.textLabel!.text = "Every \(weekdays[indexPath.row])"
        return cell
    }
    
    
}
extension AddRoutineViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
