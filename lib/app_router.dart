import 'package:flutter/material.dart';

import 'ui/home.dart';
import 'ui/item_details_screen.dart';

class AppRouter {
//constants for named routes
  static const String home = '/';
  static const String itemDetailsPage = 'itemDetailsPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => HomePage(),
        );

      case itemDetailsPage:
        var argsMap = Map.from(settings.arguments as Map<String, dynamic>);

        String title = argsMap['title'];
        String dateTime = argsMap['dateTime'];
        String location = argsMap['location'];
        String imageUrl = argsMap['imageUrl'];
        int eventId = argsMap['eventId'];

        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => ItemDetailsScreen(
            eventId: eventId,
            title: title,
            imageUrl: imageUrl,
            location: location,
            dateTime: dateTime,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}
