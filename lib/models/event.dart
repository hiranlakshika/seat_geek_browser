import 'performer.dart';
import 'venue.dart';

class Event {
  late final int eventId;
  late final String title;
  late final String dateTime;
  late final Venue venue;
  late final List<Performer> performers;

  Event({
    required this.eventId,
    required this.title,
    required this.dateTime,
    required this.venue,
    required this.performers,
  });

  Event.fromJson(Map<String, dynamic> json) {
    eventId = json['id'];
    title = json['title'];
    dateTime = json['datetime_utc'];
    venue = Venue.fromJson(json['venue']);
    performers = List<Performer>.from(json['performers']?.map((model) => Performer.fromJson(model)));
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = eventId;
    data['title'] = title;
    data['datetime_utc'] = dateTime;
    data['venue'] = venue.toJson();
    data['performer'] = performers;
    return data;
  }
}
