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
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
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
            final auction = Auction.fromJson(json);
            return Card(elevation:5, color: Colors.amber, child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(auction.image,
                  fit: BoxFit.contain
                  ),
                ),
                Text(auction.showPrice(), style:  Theme.of(context).textTheme.caption),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(auction.title, style: Theme.of(context).textTheme.headline6,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(user.name ?? '', style:  Theme.of(context).textTheme.caption),
                ),
                auction.isActive() ? ElevatedButton(onPressed: () => {
                  auction.updatePrice(500),
                  auctionDao.saveAuction(snapshot.key!, auction)
                }, child: const Text("Bid")) 
                : ElevatedButton(
                  onPressed: () => {
                  auction.registeredUsers!.add(user.id),
                  auctionDao.saveAuction(snapshot.key!, auction)
                }, child:  Text(auction.isRegistered(user) ? "Register": "Registered")) 
              ],
            ),)
            ;
          },
        ),
      )
      
      // Align(
      //   alignment: const Alignment(0, -1 / 3),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: <Widget>[
      //       Avatar(photo: user.photo),
      //       const SizedBox(height: 4),
      //       Text(user.email ?? '', style: textTheme.headline6),
      //       const SizedBox(height: 4),
      //       Text(user.name ?? '', style: textTheme.headline5),
      //     ],
      //   ),
      // ),
    );
  }
}
