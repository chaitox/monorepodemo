import 'package:get_it/get_it.dart';
import 'package:gms/gms.dart';

final getIt = GetIt.instance;
Future<void> setUpDependencies() async {
  GetIt.I.registerSingleton<Demo>(
    CrashlyticsFactory.create(),
  );
}
