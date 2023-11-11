//
//  DataManager.swift
//  Routinator
//
//  Created by Ivan Lebed on 05/11/2023.
//

import Foundation

class ChoresDataManager {
    private var items:[Chore] = []
    let debug = true
    
    func fetch() {
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
                    timeStart: minutes+i,
                    duration: 1)
                items.append(chore)
            }
        } else {
            if let file = Bundle.main.url(forResource: "debug", withExtension: "json") {
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
}
