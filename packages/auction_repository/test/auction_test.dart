import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Auction', () {
    test('Auction should be ended when auction end date is in the past', () {
      final thePast = DateTime(2000, 04, 29);
      final auction =
          Auction(thePast, "", 0.0, DateTime(2000), "", "", "", false, []);

      expect(auction.isEnded(), equals(true));
    });
    test('Auction should not be ended when auction end date is in the future',
        () {
      final theFuture = DateTime(3000, 04, 29);
      final auction =
          Auction(theFuture, "", 0.0, DateTime(2000), "", "", "", false, []);

      expect(auction.isEnded(), equals(false));
    });

    test(
        'User should be able to register for auction if they are not already registered',
        () {
      final auction = Auction(
          DateTime(2000), "", 0.0, DateTime(2000), "", "", "", false, []);
      const user = User(id: "Steven");
      auction.register(user);
      expect(auction.isRegistered(user), equals(true));
    });
    test('User should be registered for auction if registered users is null',
        () {
      final auction = Auction(
          DateTime(2000), "", 0.0, DateTime(2000), "", "", "", false, null);
      const user = User(id: "Steven");
      expect(auction.isRegistered(user), equals(false));
    });
    test(
        'User should be able to register for auction if registered users is null',
        () {
      final auction = Auction(
          DateTime(2000), "", 0.0, DateTime(2000), "", "", "", false, null);
      const user = User(id: "Steven");
      auction.register(user);
      expect(auction.isRegistered(user), equals(true));
    });

    test('User should not be registered for auction if not in registered users',
        () {
      final auction = Auction(DateTime(2000), "", 0.0, DateTime(2000), "", "",
          "", false, ["Keren"]);
      const user = User(id: "Steven");
      expect(auction.isRegistered(user), equals(false));
    });
  });
}
