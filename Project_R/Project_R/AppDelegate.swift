//
//  AppDelegate.swift
//  SarvodayaHB
//
//  Created by CZ Ltd on 12/13/17.
//  Copyright © 2017 CZ Ltd. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging
import Fabric
import Crashlytics
import CoreData
import GooglePlaces


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {

    var window: UIWindow?
    var Userdefaults = UserDefaults.standard
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        Fabric.with([Crashlytics.self] )
     
        //CheckIn view - textfield location search
     
        setUpGoogleMaps()
     
        // Override point for customization after application launch.
        // change the tint color on the Tab Bar to Wet Asphalt
//
//        UNUserNotificationCenter.current().delegate = self as! UNUserNotificationCenterDelegate
//
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
//            print("granted: (\(granted)")
//        }
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }


        UIApplication.shared.registerForRemoteNotifications() //(I)
        
        UITabBar.appearance().tintColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1)
        
        // Connect to Firebase content
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        
//        try! Auth.auth().signOut()

                if Auth.auth().currentUser != nil {
        

                    let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "TabBarID")
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    self.window?.rootViewController = controller
                    self.window?.makeKeyAndVisible()
        
                }

        
        
        var initialViewController: UIViewController?
//        if let username = UserDefaults.standard.value(forKey: "emailTextField") {
//        if Auth.auth().currentUser != nil {
//            let mainStoryboard : UIStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
//
//            initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarID")
//        } else {
//            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Start", bundle: nil)
//
//            initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "SignUpViewController")
//        }
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = initialViewController
//        self.window?.makeKeyAndVisible()
//
//        Thread.sleep(forTimeInterval: 3.0)
//    }
        
    
        
        let remoteNotif = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? NSDictionary
        
        if remoteNotif != nil {
            
            let aps = remoteNotif!["aps" as NSString] as? [String:String]
            let apsString =  String(describing: aps)
            debugPrint("\n last incoming aps: \(apsString)")
        
        }
        else {
            
            NSLog("//////////////////////////Normal launch")
        }
        
        
        
        return true
    }
    
    //Delegate Func for Location search in Check In view controller
    func setUpGoogleMaps() {
        let googleMapsApiKey = "AIzaSyDmfYE1gIA6UfjrmOUkflK9kw0nLZf0nYw"
        GMSPlacesClient.provideAPIKey("AIzaSyDmfYE1gIA6UfjrmOUkflK9kw0nLZf0nYw")
    }
    
    
    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("token: \(token)")
        
//        self.Userdefaults.set(token, forKey: "token")
        
        // Convert token to string
        _ = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        Auth.auth().setAPNSToken((deviceToken as NSData) as Data, type: AuthAPNSTokenType.sandbox)
        
//        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
//        print(token)

    }
    
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        print("failed to register for remote notifications with with error: \(error)")
//    }
    
    // The callback to handle data message received via FCM for devices running iOS 10 or above.
    func application(received remoteMessage: MessagingRemoteMessage) {
        
        print("remoteMessage.appData: \(remoteMessage.appData)")
        
        //let msg = remoteMessage.appData
        
        //notificationMessages.append(msg)
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {

        print("Firebase registration token: \(fcmToken)")
        
        self.Userdefaults.set(fcmToken, forKey: "token")
        
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo["gcm.message_id"] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo["gcm.message_id"] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }

    

}


@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
     
        // Print message ID.
        if let messageID = userInfo["gcm.message_id"] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        guard
            let aps = userInfo[AnyHashable("aps")] as? NSDictionary,
            let alert = aps["alert"] as? NSDictionary,
            let body = alert["body"] as? String,
            let title = alert["title"] as? String,
            let postId = userInfo[AnyHashable("Redirect")] as? String
            else {
                // handle any error here
                return
        }
        
        print("body text value \(body)")
        print("title value \(title)")
        print("alert value  \(alert)")
        print("aps value \(aps)")
        print("post id \(postId)")
        
//        var notDict = [String : String]()
        
//        notDict = ["notification" : body,
//                   "title" : title
//                ]
        
    
        let db = Firestore.firestore()
        db.collection("Notifications").document((API.User.CURRENT_USER?.uid)!).setData([
            "notification" : body,
             "title" : title
//             "postId" : postId
            ]
           )
        
        // Change this to your preferred presentation option
        completionHandler([.alert,.badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo["gcm.message_id"] {
            print("Message ID: \(messageID)")
        }
        
        
        // Print full message.
        print(userInfo)
    
        completionHandler()
    }
}
