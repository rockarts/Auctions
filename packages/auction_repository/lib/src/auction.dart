import 'package:authentication_repository/authentication_repository.dart';

class Auction {
  DateTime end;
  String image;
  double price;
  DateTime start;
  String title;
  String vendor;
  String topBidder;
  bool isActive;
  List<String>? registeredUsers;

  Auction(
    this.end,
    this.image,
    this.price,
    this.start,
    this.title,
    this.vendor,
    this.topBidder,
    this.isActive,
    this.registeredUsers,
  );

  bool isEnded() {
    final now = DateTime.now();

    if (end.compareTo(now) < 0) {
      return true;
    } else {
      return false;
    }
  }

  void register(User user) {
    if (!isRegistered(user)) {
      registeredUsers ??= [];
      registeredUsers!.add(user.id);
    }
  }

  bool isRegistered(User user) {
    if (registeredUsers == null) {
      return false;
    } else {
      return registeredUsers!.contains(user.id);
    }
  }

  Auction.fromJson(Map<dynamic, dynamic> json)
      : end = DateTime.parse(json["end"]),
        image = json["image"],
        price = (json["price"])?.toDouble(),
        start = DateTime.parse(json["start"]),
        title = json["title"],
        vendor = json["vendor"],
        topBidder = json["top_bidder"],
        isActive = json["isActive"],
        registeredUsers = json["registeredUsers"] == null
            ? null
            : List<String>.from(json["registeredUsers"].map((x) => x));

  Map<String, dynamic> toJson() => {
        "end": end.toIso8601String(),
        "image": image,
        "price": price,
        "start": start.toIso8601String(),
        "title": title,
        "vendor": vendor,
        "top_bidder": topBidder,
        "isActive": isActive,
        "registeredUsers": registeredUsers == null
            ? null
            : List<dynamic>.from(registeredUsers!.map((x) => x)),
      };
}
