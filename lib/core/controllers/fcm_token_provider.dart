import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fcm_token_provider.g.dart';

@riverpod
FutureOr<String> saveFCMToken(SaveFCMTokenRef ref) async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token = await messaging.getToken();
  return token!;
}
