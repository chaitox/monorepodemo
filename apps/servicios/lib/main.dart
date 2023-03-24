import 'dart:async';
import 'dart:isolate';

import 'package:cloud_services/cloud_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:servicios/firebase_options.dart';
import 'package:servicios/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpDependencies();
  final crashlyticsRepository = getIt<CrashlitycsRepository>();
  await crashlyticsRepository.setUp(
      options: DefaultFirebaseOptions.currentPlatform);
  try {
    await runZonedGuarded<Future<void>>(
      () async => runApp(const MyApp()),
      crashlyticsRepository.recordError,
    );
    // runApp(const MyApp());
    FlutterError.onError = (details) => crashlyticsRepository.recordError(
          details.exception,
          details.stack ?? StackTrace.current,
        );

    PlatformDispatcher.instance.onError = (error, stack) {
      crashlyticsRepository.recordError(error, stack);
      return true;
    };
    Isolate.current.addErrorListener(
      RawReceivePort((List<dynamic> errorAndStacktrace) async {
        await crashlyticsRepository.recordError(
          errorAndStacktrace.first,
          errorAndStacktrace.last as StackTrace,
        );
      }).sendPort,
    );
  } catch (e) {
    await crashlyticsRepository.recordError(e, StackTrace.current);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
            child: ElevatedButton(
                onPressed: () {
                  throw Exception('Error!');
                },
                child: const Text('lanzar error'))),
      ),
    );
  }
}
