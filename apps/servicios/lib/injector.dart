import 'package:cloud_services/crashlitycs_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:gms/gms.dart';

final getIt = GetIt.instance;
Future<void> setUpDependencies() async {
  GetIt.I.registerSingleton<CrashlitycsRepository>(
    CrashlyticsFactory.create(),
  );
}
