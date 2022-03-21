//
//  LocalNotificationManager.swift
//  Fuel It
//
//  Created by Jakub Chojak on 21/03/2022.
//

import Foundation
import SwiftUI
import MapKit

class LocalNotificationManager: ObservableObject {
    var notifications = [Notification]()
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                    if granted == true && error == nil {
                        print("Notifications permitted")
                    } else {
                        print("Notifications not permitted")
                    }
                }
    }
    
    func sendNotification(title: String, subtitle: String?, body: String, coords: CLLocationCoordinate2D) {
            let content = UNMutableNotificationContent()
            content.title = title
            if let subtitle = subtitle {
                content.subtitle = subtitle
            }
            content.body = body
               
            let imageName = "fuel"
            guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: "png") else { return }
            let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
            content.attachments = [attachment]
        
            let trigger = UNLocationNotificationTrigger(region: CLCircularRegion(center: coords, radius: 2000.0, identifier: "bestDealStation"), repeats: true)
            let request = UNNotificationRequest(identifier: "petrolInTheNearby", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
}
