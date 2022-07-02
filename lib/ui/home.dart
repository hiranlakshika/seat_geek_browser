import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../blocs/seat_geek_bloc.dart';
import '../models/objectbox/favorite_event.dart';
import '../util/custom_search_delegate.dart';
import 'item_details_screen.dart';
import 'list_item.dart';

class HomePage extends StatelessWidget {
  final SeatGeekBloc _seatGeekBloc = GetIt.I<SeatGeekBloc>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => showSearch(context: context, delegate: CustomSearchDelegate()),
            icon: const Icon(Icons.search),
            tooltip: 'Search',
          ),
        ],
      ),
      body: FutureBuilder(
          future: _seatGeekBloc.initRemoteConfig(),
          builder: (BuildContext context, AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              _loadingWidget();
            }
            if (snapshot.hasData) {
              debugPrint('Firebase Remote Config initialized');
            }
            _seatGeekBloc.getFavoriteEvents();
            return StreamBuilder<List<FavoriteEvent>>(
                stream: _seatGeekBloc.savedEventsStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    _loadingWidget();
                  }

                  if (snapshot.hasError) {
                    return _emptySavedItemsText();
                  }
                  var result = snapshot.data;

                  if (result == null || result.isEmpty) {
                    return _emptySavedItemsText();
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        String title = result[index].title;
                        String dateTime = result[index].dateTime;
                        String location = result[index].displayLocation;
                        String imageUrl = result[index].image;
                        int eventId = result[index].eventId;

                        return ListItem(
                          title: title,
                          dateTime: dateTime,
                          location: location,
                          imageUrl: imageUrl,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ItemDetailsScreen(
                                          title: title,
                                          dateTime: dateTime,
                                          location: location,
                                          imageUrl: imageUrl,
                                          eventId: eventId,
                                        )));
                          },
                        );
                      },
                    ),
                  );
                });
          }),
    );
  }

  Widget _loadingWidget() {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }

  Widget _emptySavedItemsText() {
    return const Center(
      child: Text('You don\'t have any saved events.'),
    );
  }
}
