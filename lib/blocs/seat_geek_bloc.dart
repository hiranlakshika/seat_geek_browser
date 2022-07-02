import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../models/event.dart';
import '../repository/remote_config_repository.dart';
import '../repository/seat_geek_repository.dart';
import 'bloc_holder.dart';

class SeatGeekBloc extends BlocBase {
  /* Repositories */
  final RemoteConfigRepository _remoteConfigRepository = GetIt.I<RemoteConfigRepository>();
  final SeatGeekRepository _seatGeekRepository = GetIt.I<SeatGeekRepository>();

  @override
  void dispose() {
    // TODO: implement dispose
  }

  Future<FirebaseRemoteConfig> initRemoteConfig() async => await _remoteConfigRepository.initRemoteConfig();

  Future<List<Event>?> getSearchResults(String searchQuery) async => await _seatGeekRepository.getEvents(searchQuery);

  String getFormattedDateTime(String dateTime) {
    DateTime dt = DateTime.parse(dateTime);
    String formattedDate = DateFormat.yMMMEd().add_jm().format(dt);
    return formattedDate;
  }
}
