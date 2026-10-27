# firebase_otp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Run `flutter pub get` to download the dependencies. Since `pubspec.lock` is
checked in, Pub uses the locked versions when they still satisfy `pubspec.yaml`;
it updates the lockfile only when dependency constraints or the resolution
change.

## Run on iOS

The checked-in Firebase iOS configuration matches the `banana` flavor. To run
it in an iOS simulator:

```sh
flutter pub get
flutter devices
flutter run --flavor banana -d <simulator-id>
```

Each additional iOS flavor needs its own matching `GoogleService-Info.plist`.

## Run on Android

The Android Firebase configuration also includes the `banana` flavor. To run
it on an emulator or connected device:

```sh
flutter pub get
flutter devices
flutter run --flavor banana -d <android-device-id>
```
