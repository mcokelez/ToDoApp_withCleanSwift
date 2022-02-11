//
//  LocalNotificationManager.swift
//  ToDoApp
//
//  Created by MAVİ on 10.02.2022.
//

import Foundation
import UserNotifications
import UIKit

class LocalNotificationManager: NotificationManager {
    static let shared = LocalNotificationManager()
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAuthorization() {
        notificationCenter
          .requestAuthorization(options: [.alert, .sound, .badge]) { permissionGranted, _ in
            if (!permissionGranted){
                print("Permission Denied.")
            }
          }
    }
    
    func fetchNotificationSettings(_ view: UIViewController, item: ToDo) {
        notificationCenter
            .getNotificationSettings { settings in
          DispatchQueue.main.async {
            if settings.authorizationStatus == .authorized  && item.deadline?.dateAsPrettyString !=  "01.02.2022"{
                self.scheduleNotification(item: item)
                let ac = UIAlertController(title: "Notification Scheduled", message: "At " + item.deadline!.dateAsPrettyString, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in}))
                view.present(ac, animated: true)
            } else {
                let ac = UIAlertController(title: "Enable Notifications?",
                                           message: "To use this feature you must enable notifications in settings",
                                           preferredStyle: .alert)
                let goToSettings = UIAlertAction(title: "Settings", style: .default)
                { (_) in
                    guard let setttingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
                    if(UIApplication.shared.canOpenURL(setttingsURL))
                    {
                        UIApplication.shared.open(setttingsURL) { (_) in}
                    }
                }
                ac.addAction(goToSettings)
                ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in}))
                view.present(ac, animated: true, completion: nil)
            }
          }
        }
    }
    
    func removeScheduledNotification(item: ToDo) {
        notificationCenter
            .removePendingNotificationRequests(withIdentifiers: [item.id!.uuidString])
    }
    
    func scheduleNotification(item: ToDo) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder for \(item.title!)"
        content.body = "Could you do your \(item.title!)? Your deadline has finished."
        content.sound = .default
    
        let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute],
                                                       from: item.deadline!)
        let trigger =  UNCalendarNotificationTrigger(dateMatching: dateComp,
                                                     repeats: false)
        let request = UNNotificationRequest(identifier: item.id!.uuidString,
                                            content: content,
                                            trigger: trigger)
        notificationCenter.add(request) { (error) in
            if error != nil {
                print("notificaiton error")
            }
        }
       
    }
    
    
   
}
