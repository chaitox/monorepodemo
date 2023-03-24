import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:gms/gms.dart';

class DemoImpl implements Demo {
  @override
  Future<void> setUp({FirebaseOptions? options}) async {
    await Firebase.initializeApp(options: options);
  }

  @override
  Future<void> recordError(dynamic exception, StackTrace stack) async {
    await FirebaseCrashlytics.instance
        .recordError(exception, stack, fatal: true);
  }

  @override
  Future<void> recordUncaughtError(FlutterErrorDetails details) async {
    await FirebaseCrashlytics.instance.recordFlutterError(details);
  }

  @override
  Future<void> setUserIdentifier(String userID) async {
    await FirebaseCrashlytics.instance.setUserIdentifier(userID);
    await FirebaseAnalytics.instance.setUserId(id: userID);
  }

  @override
  Future<void> crashCustomErrors(String message) async {
    await FirebaseCrashlytics.instance.log(message);
  }
}

class CrashlyticsFactory {
  static Demo create() {
    return DemoImpl();
  }
}
