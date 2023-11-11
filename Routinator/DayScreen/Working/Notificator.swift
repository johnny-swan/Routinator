//
//  Notificator.swift
//  Routinator
//
//  Created by Ivan Lebed on 08/11/2023.
//

import Foundation
import UserNotifications

class Notificator {
    
    func createN(task: String, timeInterval: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Start new task!"
        content.body = "You should move on to the task: \(task)"
        content.userInfo = ["content-available": 1]

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInterval), repeats: false) // n minutes
        let request = UNNotificationRequest(identifier: "YourNotificationIdentifier", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }

    }
}
