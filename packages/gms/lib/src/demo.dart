import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

abstract class Demo {
  Future<void> setUp({FirebaseOptions? options});
  Future<void> recordUncaughtError(FlutterErrorDetails details);
  Future<void> recordError(dynamic exception, StackTrace stack);
  Future<void> setUserIdentifier(String userID);
  Future<void> crashCustomErrors(String message);
}
