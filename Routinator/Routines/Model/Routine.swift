//
//  Routine.swift
//  Routinator
//
//  Created by Ivan Lebed on 12/11/2023.
//

import Foundation

// Routine is a day time table with all task user has to day one by one
class Routine: Decodable {
    var name: String?
    var weekday: Array<Int> = []
}
