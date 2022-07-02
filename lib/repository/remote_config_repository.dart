import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';

import '../resources/remote_config_provider.dart';

class RemoteConfigRepository {
  final _apiProvider = GetIt.I<RemoteConfigProvider>();

  Future<FirebaseRemoteConfig> initRemoteConfig() async => await _apiProvider.initRemoteConfig();
}
