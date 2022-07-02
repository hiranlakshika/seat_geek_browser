import 'package:get_it/get_it.dart';
import 'blocs/seat_geek_bloc.dart';
import 'repository/remote_config_repository.dart';
import 'repository/seat_geek_repository.dart';

import 'resources/remote_config_provider.dart';
import 'resources/seat_geek_api_provider.dart';
import 'util/navigation_utils.dart';

injectDependencies() {
  //Api Provider
  GetIt.I.registerLazySingleton(() => RemoteConfigProvider());
  GetIt.I.registerLazySingleton(() => SeatGeekApiProvider());

  // Repositories
  GetIt.I.registerLazySingleton(() => SeatGeekRepository());
  GetIt.I.registerLazySingleton(() => RemoteConfigRepository());

  // Singleton Blocs
  GetIt.I.registerLazySingleton(() => SeatGeekBloc());

  // Navigation Utils
  GetIt.I.registerLazySingleton(() => NavigationUtils());
}
