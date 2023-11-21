//
//  Chore.swift
//  Routinator
//
//  Created by Ivan Lebed on 05/11/2023.
//

import Foundation

class Chore: Decodable {
    var name: String?
    var desc: String?
    // timeStart, timeEnd, Duration is keep as minutes after midnight
    var timeStart: Int?
    var duration: Int?
    var timeEnd: Int? { timeStart! + duration! }
    
    var timeStartValue:Date? {
        if let minutes = timeStart {
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: Date())
            let time = startOfDay.addingTimeInterval(TimeInterval(60*minutes))
        return time
        } else { return nil }
    }
    
    var timeEndValue:Date? {
        if let minutes = timeEnd {
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: Date())
            let time = startOfDay.addingTimeInterval(TimeInterval(60*minutes))
        return time
        } else { return nil }
    }
 
    init(name: String, desc: String = "", timeStart: Int, duration: Int) {
        self.name = name
        self.desc = desc
        self.timeStart = timeStart
        self.duration = duration
    }

    class func getTimeString(_ minutes: Int?) -> String {
        if let minutes = minutes {
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: Date())
            let time = startOfDay.addingTimeInterval(TimeInterval(60*minutes))
            
            let currentHour = calendar.component(.hour, from: time)
            let currentMinute = calendar.component(.minute, from: time)
            return String(format: "%02d:%02d", currentHour, currentMinute)
        } else { return "--:--" }
    }
    
    var timeLeft: Int? {
        
        if let timeStart = timeStart, let duration = duration {
            let calendar = Calendar.current
            let now = Date()
            let startOfDay = calendar.startOfDay(for: Date())
            let startDate = startOfDay.addingTimeInterval(TimeInterval(timeStart*60))
            let finishDate = startDate.addingTimeInterval(TimeInterval(duration*60))
            if (now < startDate) || (now > finishDate) {
                return nil
            } else {
                return Int(finishDate.timeIntervalSince(now)/60)
            }
        } else {
            return nil
        }
        
    }
    
    var isRunnignNow: Bool {
        if let timeStart = timeStart, let duration = duration {
            let calendar = Calendar.current
            let now = Date()
            let startOfDay = calendar.startOfDay(for: Date())
            let startDate = startOfDay.addingTimeInterval(TimeInterval(timeStart*60))
            let finishDate = startDate.addingTimeInterval(TimeInterval(duration*60))
            return (now > startDate) && (now < finishDate)
        } else {
            return false
        }
    }
}

extension Chore: CustomStringConvertible {
    var description: String {
        return "Task: \(name ?? "Noname"), starts at \(Chore.getTimeString(timeStart ?? 0)) for \(duration ?? 0) minutes"
    }
    
    
}
