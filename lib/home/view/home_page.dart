import 'package:auction/home/view/home_view_model.dart';
import 'package:auction_repository/auction_repository.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auction/app/app.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  static Page page() => MaterialPage<void>(child: HomePage());
  final ScrollController _scrollController = ScrollController();
  final auctionDao = AuctionDao();

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: <Widget>[
            IconButton(
              key: const Key('homePage_logout_iconButton'),
              icon: const Icon(Icons.exit_to_app),
              onPressed: () =>
                  context.read<AppBloc>().add(AppLogoutRequested()),
            )
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FirebaseAnimatedList(
            controller: _scrollController,
            query: auctionDao.getAuctionsQuery(),
            itemBuilder: (context, snapshot, animation, index) {
              final json = snapshot.value as Map<dynamic, dynamic>;
              final homeViewModel = HomeViewModel();
              homeViewModel.auction = Auction.fromJson(json);
              return Card(
                elevation: 5,
                color: Colors.amber,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(homeViewModel.getImage(),
                          fit: BoxFit.contain),
                    ),
                    Text(homeViewModel.showPrice(),
                        style: Theme.of(context).textTheme.caption),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        homeViewModel.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Text("Top Bidder: ${homeViewModel.topBidder}"),
                    Text("Start Time: ${homeViewModel.getStartDate()}"),
                    Text("End Time: ${homeViewModel.getEndDate()}"),
                    homeViewModel.isActive()
                        ? ElevatedButton(
                            onPressed: () =>
                                {homeViewModel.placeBid(snapshot.key, user)},
                            child: const Text("Bid"))
                        : homeViewModel.auctionEnded()
                            ? ElevatedButton(
                                onPressed: () => {}, child: const Text("Ended"))
                            : ElevatedButton(
                                onPressed: () => {
                                      homeViewModel.register(snapshot.key, user)
                                    },
                                child: Text(
                                    homeViewModel.registerButtonText(user)))
                  ],
                ),
              );
            },
          ),
        ));
  }
}
