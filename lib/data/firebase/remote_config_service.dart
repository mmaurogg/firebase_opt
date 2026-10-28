import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 100),
        minimumFetchInterval: Duration(hours: 1),
      ),
    );

    await _remoteConfig.setDefaults(const {
      'maintenance_mode': true,
      'app_color': '#FF0000',
      'welcome_message': 'Bienvenido',
    });

    await _remoteConfig.fetchAndActivate();
  }

  bool get maintenanceMode => _remoteConfig.getBool('maintenance_mode');
  String get appColor => _remoteConfig.getString('app_color');
  String get welcomeMessage => _remoteConfig.getString('welcome_message');
  String get test => _remoteConfig.getString('test');
  String get imageUrl => _remoteConfig.getString('image_url');
}
