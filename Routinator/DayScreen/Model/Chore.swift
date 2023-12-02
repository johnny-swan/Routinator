//
//  Chore.swift
//  Routinator
//
//  Created by Ivan Lebed on 05/11/2023.
//

import Foundation

class Chore: Decodable, Encodable {
    var name: String?
    var desc: String?
    
    var timeStart: TimeStamp?
    var duration: TimeStamp?
    var timeEnd: TimeStamp? { timeStart! + duration! }
    
    /// calculate it everytime timer fires
    var timeLeft: TimeStamp? {
        
        let now = Date()
        if now.isBetween(from: timeStart!, to: timeEnd!) {
            return TimeStamp(fromMinutes: Int(timeEnd!.toDate().timeIntervalSince(now)/60))
        } else { return nil }        
    }
    
    init(name: String, desc: String = "", timeStart: TimeStamp, duration: TimeStamp) {
        self.name = name
        self.desc = desc
        self.timeStart = timeStart
        self.duration = duration
    }

    var isRunnignNow: Bool {
        let now = Date()
        return now.isBetween(from: timeStart!, to: timeEnd!)
    }
}

extension Chore: CustomStringConvertible {
    var description: String {
        return "Task: \(name ?? "Noname"), starts at \(timeStart!.toString(as: .clock)) for \(duration!.toString(as: .compact)) minutes"
    }
}

extension Chore: Comparable {
    static func < (lhs: Chore, rhs: Chore) -> Bool {
        return lhs.timeStart! < rhs.timeStart!
    }
    
    static func == (lhs: Chore, rhs: Chore) -> Bool {
        return lhs.timeStart! == rhs.timeStart!
    }
    
    
}
