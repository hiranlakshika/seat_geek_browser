import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:seat_geek_browser/repository/remote_config_repository.dart';
import 'package:seat_geek_browser/repository/seat_geek_repository.dart';
import 'package:seat_geek_browser/resources/remote_config_provider.dart';
import 'package:seat_geek_browser/resources/seat_geek_api_provider.dart';

main() async {
  //This test does not work due to the Firebase remote config. Need to find a proper solution for that
  GetIt locator = GetIt.instance;

//injecting dependencies
  locator.registerLazySingleton<RemoteConfigProvider>(() => RemoteConfigProvider());
  locator.registerLazySingleton<SeatGeekApiProvider>(() => SeatGeekApiProvider());
  locator.registerLazySingleton<SeatGeekRepository>(() => SeatGeekRepository());
  locator.registerLazySingleton<RemoteConfigRepository>(() => RemoteConfigRepository());

  var remoteConfigRepo = GetIt.I<RemoteConfigRepository>();
  var seatGeekApiRepo = GetIt.I<SeatGeekRepository>();

  await remoteConfigRepo.initRemoteConfig();

  const String searchQuery = 'Texas';

  group("fetch events testing", () {
    test('fetch events by search key', () async {
      var events = await seatGeekApiRepo.getEvents(searchQuery);
      // assert
      expect(events, isNotNull);
    });
  });
}
