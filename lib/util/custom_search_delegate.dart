import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:seat_geek_browser/models/event.dart';

import '../app_router.dart';
import '../blocs/seat_geek_bloc.dart';
import '../ui/list_item.dart';
import 'navigation_utils.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SeatGeekBloc _seatGeekBloc = GetIt.I<SeatGeekBloc>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Event>?>(
        future: _seatGeekBloc.getSearchResults(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Nothing found'));
          }

          var result = snapshot.data;

          if (result != null) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  String title = result[index].title;
                  String dateTime = _seatGeekBloc.getFormattedDateTime(result[index].dateTime);
                  String location = result[index].venue.displayLocation;
                  String imageUrl = result[index].performers.first.image;
                  bool isFavorite = _seatGeekBloc.getSavedEvent(result[index].eventId) != null;
                  int eventId = result[index].eventId;

                  return ListItem(
                    title: title,
                    dateTime: dateTime,
                    location: location,
                    imageUrl: imageUrl,
                    isFavorite: isFavorite,
                    onTap: () => GetIt.I<NavigationUtils>().pushNamed(AppRouter.itemDetailsPage, arguments: {
                      'title': title,
                      'dateTime': dateTime,
                      'location': location,
                      'imageUrl': imageUrl,
                      'eventId': eventId,
                    }),
                  );
                },
              ),
            );
          }
          return const Center(child: Text('Nothing found'));
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }
}
