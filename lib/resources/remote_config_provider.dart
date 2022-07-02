import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigProvider {
  Future<FirebaseRemoteConfig> initRemoteConfig() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 1), // a fetch will wait up to 10 seconds before timing out
      minimumFetchInterval: const Duration(seconds: 10), // fetch parameters will be cached for a maximum of 1 hour
    ));

    await remoteConfig.fetchAndActivate();
    return remoteConfig;
  }
}
