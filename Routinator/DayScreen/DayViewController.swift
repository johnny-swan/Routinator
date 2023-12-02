//
//  DayViewController.swift
//  Routinator
//
//  Created by Ivan Lebed on 05/11/2023.
//

import UIKit
import Foundation

class DayViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var lblMyDay: UILabel!
    
    let notificator = Notificator()
    
    let manager = ChoresDataManager(routine: nil, debug: false)
    
    
    
    var currentChore: Int? {
        willSet { print("new currentChore will set") }
        didSet { setNewChore(oldValue: oldValue ?? 0, newValue: currentChore!) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        manager.fetch()
        currentChore = getCurrentIndex()
        
        initialize()
       
    }

    func setNewChore(oldValue: Int, newValue: Int) {
        print("new chore set\nit was \(oldValue) and now it is \(newValue)")
//        let newChore = manager.chore(atInt: newValue)
//        notificator.createN(task: newChore.name!, timeInterval: 5)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager.fetch()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollToCurrent()
    }
    func scrollToCurrent() {
        if let currentChore = currentChore {
            if currentChore > 0 {
                let indexPath = IndexPath(row: currentChore, section: 0)
                tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
            }
            
        }
        
    }
    func initialize() {
        let now = Date()
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let dateString = dateFormatter.string(from: now)
        lblMyDay.text = dateString
        
    }
    @objc func update() {
        tableView.reloadData()
        
        // reloadRows should work good in between changing currentChores, but it
        // not move current correctly, should work on it later
        // TODO: update only current cell, update cells by timer once in a while
        // or maybe update cell by itself?
        
//        tableView.reloadRows(at: [IndexPath(row: currentChore!, section: 0)], with: .none)
        
    }
    
    func getCurrentIndex() -> Int {
        for i in 0..<manager.numberOfItems() {
            if manager.chore(atInt: i).isRunnignNow {
                return i
            }
        }
        return 0
    }
}

extension DayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chore = manager.chore(at: indexPath)
        let startTime = chore.timeStart!
        let endTime = chore.timeEnd!
        if Date().isBetween(from: startTime, to: endTime) {
            if currentChore! != indexPath.row {
                // call the notification
                
                // set new current chore
                currentChore = indexPath.row
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentTask", for: indexPath) as! CurrentCellView
            
            
            cell.lblCaption.text = chore.name
            cell.lblStartFrom.text = chore.timeStart!.toString(as: .clock)
            cell.lblFinishAt.text = chore.timeEnd!.toString(as: .clock)
            cell.lblDescription.text = chore.desc
            
            var timeLeftString = ""
            if chore.timeLeft!.minutes > 0 {
                timeLeftString = "\(chore.timeLeft!.toString(as: .compact)) left"
            } else {
                timeLeftString = "ending soon..."
            }
            cell.lblTimeLeft.text = timeLeftString
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingTask", for: indexPath) as! FutureCellView
            
            
            cell.lblCaption.text = chore.name
            cell.lblStartFrom.text = chore.timeStart!.toString(as: .clock)
            cell.lblFinishAt.text = chore.timeEnd!.toString(as: .clock)
            return cell
        }
        
    }
     
    
    func numberBeetween(lower: Int, upper: Int, given: Int) -> Bool {
            return given >= lower && given < upper
        }

    
    func checkIfTimeFitsIn(start: Int, end: Int) -> Bool {
        let calendar = Calendar.current
        let now = Date()

        let startOfDay = calendar.startOfDay(for: now) // Get the start of the current day
        let minutesSinceMidnight = calendar.dateComponents([.minute], from: startOfDay, to: now)

        if let minutes = minutesSinceMidnight.minute {
            return numberBeetween(lower: start, upper: end, given: minutes)
        } else {
            return false
        }
    }
    
}


extension DayViewController: UITableViewDelegate {
    
}
