enum Flavor { apple, banana }

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    return switch (appFlavor) {
      Flavor.apple => 'Apple App',
      Flavor.banana => 'Banana App',
    };
  }
}
