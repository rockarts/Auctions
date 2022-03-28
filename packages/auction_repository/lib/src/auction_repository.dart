import 'package:auction_repository/src/auction.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'package:firebase_database/firebase_database.dart';

class AuctionRepository {
  /// Returns [value] plus 1.
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  void test() {
    DatabaseReference titleRef =
        FirebaseDatabase.instance.ref('posts/ts-functions/title');
        titleRef.onValue.listen((DatabaseEvent event) {
          final data = event.snapshot.value;
          print(data);
        //updateStarCount(data);
    });
  }
}

class AuctionDao {
  final DatabaseReference _auctionsRef =
      FirebaseDatabase.instance.ref().child('auctions');

  void saveAuction(String key, Auction auction) {
    DatabaseReference _updateRef = FirebaseDatabase.instance.ref('/auctions').child(key);
    _updateRef.set(auction.toJson());
  }

  void registerForAuction(String key, Auction auction) {
    DatabaseReference _updateRef = FirebaseDatabase.instance.ref('/auctions').child(key);
    _updateRef.set(auction.toJson());
  }

  Query getAuctionsQuery() {
    return _auctionsRef;
  }

  void registerNotification(Auction auction) {
    final manager = LocationManager();
    manager.registerNotification(auction.title, "The auction is starting soon!");
  }
}

class LocationManager {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

  
  Future<void> registerNotification(String title, String body) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
      final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS
      );

      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
       tz.initializeTimeZones();
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

}