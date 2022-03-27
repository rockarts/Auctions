import 'package:authentication_repository/authentication_repository.dart';
import 'package:intl/intl.dart';

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
}

class Auction {
    DateTime end;
    String image;
    double price;
    DateTime start;
    String title;
    String vendor;
    List<String>? registeredUsers;

    Auction(
        this.end,
        this.image,
        this.price,
        this.start,
        this.title,
        this.vendor,
        this.registeredUsers,
    );

  void updatePrice(double newPrice) {
    price += newPrice;
  }

  bool isActive() {
    final now = DateTime.now();
    
    if (start.compareTo(now) < 0 && end.compareTo(now) > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isRegistered(User user) {
    if(registeredUsers == null) {
      return false; 
    } else {  
       return registeredUsers!.contains(user.id);
    }
  }

  String showPrice() {
    final currency =  NumberFormat.currency();
    if(isActive()) {
      return currency.format(price);
    }

    return "Price not shown until auction is started";
  }

     Auction.fromJson(Map<dynamic, dynamic> json) 
       : end = DateTime.parse(json["end"]),
        image = json["image"],
        price = (json["price"])?.toDouble(),
        start = DateTime.parse(json["start"]),
        title = json["title"],
        vendor = json["vendor"],
        registeredUsers = json["registeredUsers"] == null ? null : List<String>.from(json["registeredUsers"].map((x) => x));

    Map<String, dynamic> toJson() => {
        "end": end.toIso8601String(),
        "image": image,
        "price": price,
        "start": start.toIso8601String(),
        "title": title,
        "vendor": vendor,
        "registeredUsers": registeredUsers == null ? null : List<dynamic>.from(registeredUsers!.map((x) => x)),
    };

    
}

// class Auction {
//   final String title;
//   final DateTime start;
//   final DateTime end;
//   double price;
//   final String vendor;
//   final String image;
//   List<String> registeredUsers;

//   Auction({
//         this.end,
//         this.image,
//         this.price,
//         this.start,
//         this.title,
//         this.vendor,
//         this.registeredUsers,
//     });
    
//   factory Auction.fromJson(Map<String, dynamic> json) => Auction(
//         end: DateTime.parse(json["end"]),
//         image: json["image"],
//         price: json["price"],
//         start: DateTime.parse(json["start"]),
//         title: json["title"],
//         vendor: json["vendor"],
//         registeredUsers: json["registeredUsers"] == null ? null : List<String>.from(json["registeredUsers"].map((x) => x)),
//     );
//   Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
//       'title': title,
//       'start': start.toIso8601String(),
//       'end': end.toIso8601String(),
//       'price': price,
//       'vendor': vendor,
//       'image': image,
//       'registeredUsers': registeredUsers
//     };

  
// }