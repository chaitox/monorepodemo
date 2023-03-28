// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:agconnect_core/agconnect_core.dart';
import 'package:agconnect_crash_plus/agconnect_crash_plus.dart';
import 'package:cloud_services/cloud_services.dart';

import 'package:flutter/widgets.dart';

class HuaweiCrashlyticsRepositoryImpl implements CrashlitycsRepository {
  @override
  Future<void> setUp() async {
    await Future.wait([
      AGCApp.instance.setClientId('1119119688740130048'),
      AGCApp.instance.setClientSecret(
          '821062764BD1040526D3F273FDBC0FA5C65ECB72D94172043873996C006811D8'),
      AGCApp.instance.setApiKey(
          'DAEDABADPU9i22Tl8ADFo49awOzSJA0BgxF8rWeR4cp0qLG6tfK2DeoGNWnpYsUmSHnRmewm3LJF71WT+tGaj/Z9um++a/BxhbBKVw=='),
      AGCCrash.instance.enableCrashCollection(true),
    ]);
  }

  @override
  Future<void> recordError(dynamic exception, StackTrace stack) async {
    print('exception: $exception');
    print('StackTrace: $stack');
    await AGCCrash.instance.recordError(exception, stack);
  }

  @override
  Future<void> recordUncaughtError(FlutterErrorDetails details) async {
    await AGCCrash.instance.onFlutterError(details);
  }

  @override
  Future<void> crashCustomErrors(String message) {
    // TODO: implement crashCustomErrors
    throw UnimplementedError();
  }

  @override
  Future<void> setUserIdentifier(String userID) {
    // TODO: implement setUserIdentifier
    throw UnimplementedError();
  }
}

class CrashlyticsFactory {
  static CrashlitycsRepository create() {
    return HuaweiCrashlyticsRepositoryImpl();
  }
}
