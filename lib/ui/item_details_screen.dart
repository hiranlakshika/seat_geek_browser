import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:seat_geek_browser/models/objectbox/favorite_event.dart';

import '../blocs/seat_geek_bloc.dart';
import 'silver_multiline_app_bar.dart';

class ItemDetailsScreen extends StatelessWidget {
  final int eventId;
  final String title;
  final String location;
  final String dateTime;
  final String imageUrl;
  final SeatGeekBloc _seatGeekBloc = GetIt.I<SeatGeekBloc>();

  ItemDetailsScreen(
      {Key? key,
      required this.title,
      required this.location,
      required this.dateTime,
      required this.imageUrl,
      required this.eventId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverMultilineAppBar(
            title: title,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                  color: Colors.blue,
                )),
            actions: [
              StreamBuilder<List<FavoriteEvent>>(
                  stream: _seatGeekBloc.savedEventsStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    }
                    var result = snapshot.data;

                    bool isFavorite =
                        result != null && result.isNotEmpty && result.any((element) => element.eventId == eventId);

                    return IconButton(
                        onPressed: () {
                          if (isFavorite) {
                            _seatGeekBloc.removeFromFavorites(eventId);
                          } else {
                            var event = FavoriteEvent(
                                eventId: eventId,
                                title: title,
                                displayLocation: location,
                                dateTime: dateTime,
                                image: imageUrl);
                            _seatGeekBloc.addToFavorite(event);
                          }
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.blue,
                        ));
                  }),
            ],
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: imageUrl,
                            progressIndicatorBuilder: (_, __, ___) => const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    dateTime,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    location,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          fontSize: 16.0,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
