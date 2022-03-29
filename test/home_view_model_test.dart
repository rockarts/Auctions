import 'package:auction/home/view/home_view_model.dart';
import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:mockito/mockito.dart';

import 'home_view_model_test.mocks.dart';

@GenerateMocks([Auction, AuctionDao])
void main() {
  group('HomeViewModel', () {
    late Auction auction;
    late AuctionDao auctionDao;
    late HomeViewModel viewModel;

    setUp(() {
      auction = MockAuction();
      auctionDao = MockAuctionDao();
      viewModel = HomeViewModel(auctionDao: auctionDao);
      viewModel.auction = auction;
    });

    test('Should return default image when auction is not yet active', () {
      when(auction.isActive).thenReturn(false);
      String image = viewModel.getImage();
      expect(
          image,
          equals(
              "https://firebasestorage.googleapis.com/v0/b/auction-bec64.appspot.com/o/blurred_car.jpg?alt=media&token=92c9b9da-1e23-48b5-8e32-336c63a816e7"));
    });

    test('Should return auction image when auction is active', () {
      when(auction.isActive).thenReturn(true);
      when(auction.image).thenReturn("test");
      String image = viewModel.getImage();
      expect(image, equals("test"));
    });

    test('Should start format date', () {
      final date = DateTime(2022, 3, 27, 11, 12);
      when(auction.start).thenReturn(date);
      String formatted = viewModel.getStartDate();
      expect(formatted, equals("3/27/2022 11:12 AM"));
    });
    test('Should show register when user is unregistered', () {
      const user = User(id: "12345");
      when(auction.isRegistered(user)).thenReturn(false);

      String text = viewModel.registerButtonText(user);
      expect(text, equals("Register"));
    });
    test('Should show register when user is unregistered', () {
      const user = User(id: "12345");
      when(auction.isRegistered(user)).thenReturn(true);
      String text = viewModel.registerButtonText(user);
      expect(text, equals("Registered"));
    });
    test('Should not show price if auction is not active', () {
      when(auction.isActive).thenReturn(false);
      String text = viewModel.showPrice();
      expect(text, equals("Price not shown until auction is started"));
    });

    test('Should show price and format if auction is active', () {
      when(auction.isActive).thenReturn(true);
      when(auction.price).thenReturn(5.00);
      String text = viewModel.showPrice();
      expect(text, equals("USD5.00"));
    });
  });
}
