import 'package:get_it/get_it.dart';

import '../models/event.dart';
import '../resources/seat_geek_api_provider.dart';

class SeatGeekRepository {
  final _apiProvider = GetIt.I<SeatGeekApiProvider>();

  Future<List<Event>?> getEvents(String searchQuery) async => await _apiProvider.getEvents(searchQuery);
}
