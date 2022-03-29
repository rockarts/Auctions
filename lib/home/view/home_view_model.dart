import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeViewModel with ChangeNotifier {
  late AuctionDao auctionDao;

  late Auction auction;

  HomeViewModel({AuctionDao? auctionDao}) {
    this.auctionDao = auctionDao ?? AuctionDao();
  }

  String get title => auction.title;
  String get topBidder => auction.topBidder;

  String getImage() {
    if (auction.isActive) {
      return auction.image;
    } else {
      return "https://firebasestorage.googleapis.com/v0/b/auction-bec64.appspot.com/o/blurred_car.jpg?alt=media&token=92c9b9da-1e23-48b5-8e32-336c63a816e7";
    }
  }

  registerNotification(Auction auction) {
    auctionDao.registerNotification(auction);
  }

  Query getAuctionsQuery() {
    return auctionDao.getAuctionsQuery();
  }

  String registerButtonText(User user) {
    return auction.isRegistered(user) ? "Registered" : "Register";
  }

  void placeBid(String? key, User user) {
    auctionDao.placeBid(key!, auction.price + 500, user.name ?? user.id);
  }

  void register(String? key, User user) {
    auction.register(user);
    registerNotification(auction);
    auctionDao.registedUser(key!, auction.registeredUsers);
  }

  String showPrice() {
    final currency = NumberFormat.currency();
    if (auction.isActive) {
      return currency.format(auction.price);
    }

    return "Price not shown until auction is started";
  }

  bool isActive() {
    return auction.isActive;
  }

  String getStartDate() {
    return formatDate(auction.start);
  }

  String getEndDate() {
    return formatDate(auction.end);
  }

  String formatDate(DateTime date) {
    return DateFormat.yMd().add_jm().format(date);
  }
}
