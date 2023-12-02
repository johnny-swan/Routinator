//
//  DataManager.swift
//  Routinator
//
//  Created by Ivan Lebed on 05/11/2023.
//

import Foundation

class ChoresDataManager {
    private var items:[Chore] = []
    var debug = false
    var routine: Routine?
    
    
    init(routine: Routine?, debug:Bool = false) {
        self.debug = debug
    }
    
    func fetch() {
        items.removeAll()
        if debug {
            // find this date
            let calendar = Calendar(identifier: .gregorian)
            let startOfDay = calendar.startOfDay(for: Date())
            let day = Date().timeIntervalSince(startOfDay)
            let minutes: Int = Int(day)/60
            // multiply by 60
            for i in 0..<60 {
                let chore = Chore(
                    name: "chore: \(i)",
                    desc: "This is just random autocreate chore with id=\(i)",
                    timeStart: TimeStamp(fromMinutes: minutes+i),
                    duration: TimeStamp(fromMinutes: 1))
                items.append(chore)
            }
        } else {
            routine = Optional(Routine())
            routine!.name = "weekday_tt"
            if let file = Bundle.main.url(forResource: routine!.name!, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: file)
                    let chores = try JSONDecoder().decode([Chore].self, from: data)
                    items = chores
                }
                catch {
                    print("there was an error \(error)")
                }
            }
        }
        resort()
        
    }
    
    private func resort() {
        items.sort()
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func chore(at index: IndexPath) -> Chore {
        return items[index.item]
    }
    func chore(atInt intIndex: Int) -> Chore {
        return items[intIndex]
    }
    
    func updateChore(at index: IndexPath, with newChore: Chore) {
        items[index.item] = newChore
        resort()
        // rewrite JSON file
        push()
    }
    
    func push() {
        print("will save json file back")
        routine!.name = "weekday_tt"
        if let file = Bundle.main.url(forResource: routine!.name!, withExtension: "json") {
            do {
//                let data = try Data(contentsOf: file)
//                let chores = try JSONDecoder().decode([Chore].self, from: data)
//                items = chores
                
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                let data = try encoder.encode(items)
                try data.write(to: file)
            }
            catch {
                print("there was an error while writing file\(error)")
            }
        }
    }
}
