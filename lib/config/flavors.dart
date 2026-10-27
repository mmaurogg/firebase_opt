import 'dart:ui';

import 'package:firebase_otp/data/firebase/remote_config_service.dart';

enum Flavor { apple, banana }

class F {
  static late final Flavor appFlavor;

  static late final Color color;

  static String image =
      'https://www.iconpacks.net/icons/4/free-no-image-icon-14597-thumb.png';

  static String get name => appFlavor.name;

  static String get title {
    return switch (appFlavor) {
      Flavor.apple => 'Apple App',
      Flavor.banana => 'Banana App',
    };
  }

  Future<void> setBrandFromRemoteConfig() async {
    final remoteConfigService = RemoteConfigService();
    await remoteConfigService.initialize();

    image = remoteConfigService.imageUrl;
    color = Color(
      int.parse(remoteConfigService.appColor.replaceFirst('#', '0xff')),
    );
  }
}
