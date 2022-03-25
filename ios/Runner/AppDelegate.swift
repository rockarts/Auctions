import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
//    override func registerForRemoteNotifications() {
//        if ([UNUserNotificationCenter class] != nil) {
//          // iOS 10 or later
//          // For iOS 10 display notification (sent via APNS)
//          [UNUserNotificationCenter currentNotificationCenter].delegate = self;
//          UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
//              UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
//          [[UNUserNotificationCenter currentNotificationCenter]
//              requestAuthorizationWithOptions:authOptions
//              completionHandler:^(BOOL granted, NSError * _Nullable error) {
//                // ...
//              }];
//        } else {
//          // iOS 10 notifications aren't available; fall back to iOS 8-9 notifications.
//          UIUserNotificationType allNotificationTypes =
//          (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
//          UIUserNotificationSettings *settings =
//          [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
//          [application registerUserNotificationSettings:settings];
//        }
//
//        [application registerForRemoteNotifications];
//
//    }
}
