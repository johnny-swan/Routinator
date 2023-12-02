//
//  TimeStamp.swift
//  Routinator
//
//  Created by Ivan Lebed on 23/11/2023.
//

import Foundation

struct TimeStamp: Decodable, Encodable {
    var hours: Int
    var minutes: Int
    /// summ amout of minutes in given timestamp
    var totalMinutes: Int {
        return hours*60 + minutes
    }
    
    func toDate() -> Date {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        return startOfDay.addingTimeInterval(TimeInterval(60*minutes + 3600*hours))
    }
    
    init(hours: Int, minutes: Int) {
        self.hours = hours
        self.minutes = minutes
    }
    
    init(fromMinutes minutes: Int) {
        self.hours = minutes / 60
        self.minutes = minutes % 60
    }
    
    init(fromDate date: Date) {
        self.hours = Calendar.current.component(.hour, from: date)
        self.minutes = Calendar.current.component(.minute, from: date)
    }

}

// MARK: operators overloading
extension TimeStamp {
    static func +(left: TimeStamp, right: TimeStamp) -> TimeStamp {
        var hours = left.hours + right.hours
        var minutes = left.minutes + right.minutes
        if minutes >= 60 {
            minutes -= 60
            hours += 1
        }
        
        if hours >= 24 {
            hours -= 24
        }
        return TimeStamp(hours: hours, minutes: minutes)
    }
    
    static func +(left: TimeStamp, right: Int) -> TimeStamp {
        var hours = left.hours
        var minutes = left.minutes + right
        if minutes >= 60 {
            hours += 1
            minutes -= 60
        }
        return TimeStamp(hours: hours, minutes: minutes)
    }

    
    // only return value if left is greater than right, until I'll need negative time
    static func -(left: TimeStamp, right: TimeStamp) -> TimeStamp? {
        if left > right {
            var hour = left.hours - right.hours
            var minute = left.minutes - right.minutes
            if left.minutes > right.minutes {
                minute += 60
                hour -= 1
            }
            return TimeStamp(hours: hour, minutes: minute)
        } else { return nil }
        
    }
    
    func toString(as format: TimeStampFormat) -> String {
        switch format {
        case .clock:
            return String(format: "%02d:%02d", hours, minutes)
        case .compact:
            if hours > 0 {
                return String(format: "%02dh %02dm", hours, minutes)
            } else {
                return String(format: "%02dm", minutes)
            }
        case .full:
            if hours > 0 {
                return "\(hours) hours \(minutes) minutes"
            } else {
                return "\(minutes) minutes"
            }
        }
    }
}

// MARK: Date class overloading

extension Date {
    func isBetween(from lower: TimeStamp, to upper: TimeStamp) -> Bool {
        let lowerDate = lower.toDate()
        let upperDate = upper.toDate()
        
        if self < upperDate && self >= lowerDate {
            return true
        }
        
        return false
    }
}


enum TimeStampFormat {
    case full
    case compact
    case clock
}

extension TimeStamp: Comparable {
    
    static func >(left: TimeStamp, right: TimeStamp) -> Bool {
        return left.totalMinutes > right.totalMinutes
    }
    
    static func < (lhs: TimeStamp, rhs: TimeStamp) -> Bool {
        return lhs.totalMinutes < rhs.totalMinutes
    }
    static func == (lhs: TimeStamp, rhs: TimeStamp) -> Bool {
        return lhs.totalMinutes == rhs.totalMinutes
    }
    
}
