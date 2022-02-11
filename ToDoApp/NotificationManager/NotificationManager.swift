//
//  NotificationManager.swift
//  ToDoApp
//
//  Created by MAVİ on 10.02.2022.
//

import Foundation
import UIKit

protocol NotificationManager {
    func requestAuthorization()
    func fetchNotificationSettings(_ view: UIViewController, item: ToDo)
    func removeScheduledNotification(item: ToDo)
    func scheduleNotification(item: ToDo)
}
