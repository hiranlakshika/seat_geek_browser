import 'package:objectbox/objectbox.dart';

@Entity()
class FavoriteEvent {
  int id = 0;

  late final int eventId;
  late final String title;
  late final String displayLocation;
  late final String dateTime;
  late final String image;

  FavoriteEvent({
    required this.eventId,
    required this.title,
    required this.displayLocation,
    required this.dateTime,
    required this.image,
  });

}
