import 'package:cloud_services/crashlitycs_repository.dart';
import 'package:cms/cms.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
Future<void> setUpDependencies() async {
  GetIt.I.registerSingleton<CrashlitycsRepository>(
    CrashlyticsFactory.create(),
  );
}
