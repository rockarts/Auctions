
import 'package:auction/home/view/home_view_model.dart';
import 'package:auction_repository/auction_repository.dart';

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
      when(auction.isActive()).thenReturn(false);
      String image = viewModel.getImage();
      expect(image, equals("https://firebasestorage.googleapis.com/v0/b/auction-bec64.appspot.com/o/blurred_car.jpg?alt=media&token=92c9b9da-1e23-48b5-8e32-336c63a816e7"));
    });

    test('Should return auction image when auction is active', () {
      when(auction.isActive()).thenReturn(true);
      when(auction.image).thenReturn("test");
      String image = viewModel.getImage();
      expect(image, equals("test"));
    });


  });
}