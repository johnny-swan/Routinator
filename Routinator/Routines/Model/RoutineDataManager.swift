//
//  DataManager.swift
//  Routinator
//
//  Created by Ivan Lebed on 05/11/2023.
//

import Foundation

class RoutineDataManager {
    private var items:[Routine] = []
    
    func fetch() {
        items.removeAll()
        
            if let file = Bundle.main.url(forResource: "routines", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: file)
                    let routines = try JSONDecoder().decode([Routine].self, from: data)
                    items = routines
                }
                catch {
                    print("there was an error \(error)")
                }
            }
        
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func routine(at index: IndexPath) -> Routine {
        return items[index.item]
    }
    func routine(at index: Int) -> Routine {
        return items[index]
        
    }
    func addRoutine(_ newRoutine: Routine) {
        items.append(newRoutine)
        
    }
}
