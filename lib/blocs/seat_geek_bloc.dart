import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../main.dart';
import '../models/event.dart';
import '../models/objectbox/favorite_event.dart';
import '../objectbox.g.dart';
import '../repository/remote_config_repository.dart';
import '../repository/seat_geek_repository.dart';
import 'bloc_holder.dart';

class SeatGeekBloc extends BlocBase {
  /* Repositories */
  final RemoteConfigRepository _remoteConfigRepository = GetIt.I<RemoteConfigRepository>();
  final SeatGeekRepository _seatGeekRepository = GetIt.I<SeatGeekRepository>();

  /* Rxdart objects */
  final _savedEventsSubject = BehaviorSubject<List<FavoriteEvent>>();

  /* Streams */
  Stream<List<FavoriteEvent>> get savedEventsStream => _savedEventsSubject.stream;

  @override
  void dispose() {
    _savedEventsSubject.close();
  }

  Future<FirebaseRemoteConfig> initRemoteConfig() async => await _remoteConfigRepository.initRemoteConfig();

  Future<List<Event>?> getSearchResults(String searchQuery) async => await _seatGeekRepository.getEvents(searchQuery);

  String getFormattedDateTime(String dateTime) {
    DateTime dt = DateTime.parse(dateTime);
    String formattedDate = DateFormat.yMMMEd().add_jm().format(dt);
    return formattedDate;
  }

  FavoriteEvent? getSavedEvent(int eventId) {
    final eventBox = objectbox.store.box<FavoriteEvent>();
    final query = eventBox.query(FavoriteEvent_.eventId.equals(eventId)).build();

    var savedEvent = query.findUnique();
    query.close();

    if (savedEvent != null) return savedEvent;

    return null;
  }

  getFavoriteEvents() {
    final eventBox = objectbox.store.box<FavoriteEvent>();
    List<FavoriteEvent> events = eventBox.getAll();
    _savedEventsSubject.sink.add(events);
  }

  addToFavorite(FavoriteEvent event) {
    var savedEvent = getSavedEvent(event.eventId);

    if (savedEvent == null) {
      final eventBox = objectbox.store.box<FavoriteEvent>();
      eventBox.put(event);
      modifyEventsStream(eventModel: event);
    }
  }

  removeFromFavorites(int eventId) {
    var savedEvent = getSavedEvent(eventId);
    if (savedEvent != null) {
      final eventBox = objectbox.store.box<FavoriteEvent>();
      eventBox.remove(savedEvent.id);
      modifyEventsStream(isRemoving: true, eventModel: savedEvent);
    }
  }

  modifyEventsStream({bool isRemoving = false, required FavoriteEvent eventModel}) {
    var newEventsList = _savedEventsSubject.value;
    isRemoving
        ? newEventsList.removeWhere((element) => element.eventId == eventModel.eventId)
        : newEventsList.add(eventModel);
    _savedEventsSubject.sink.add(newEventsList);
  }
}
