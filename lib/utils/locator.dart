import 'package:get_it/get_it.dart';
import 'package:volo_consumer/screens/profile/logic/profile_cubit.dart';
import 'package:volo_consumer/services/services.dart';

final locator = GetIt.instance;

class ServiceLocator {
  static void registerLocator() {
    // Services
    locator.registerSingleton(() => ThemeService());
    locator.registerSingleton<AuthenticationService>(
        AuthenticationService.instance);
    locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
    locator.registerLazySingleton<CloudStorageService>(
        () => CloudStorageService());
    locator.registerLazySingleton<NavigationService>(() => NavigationService());

    //Cubits
    locator.registerLazySingleton<ProfileCubit>(() => ProfileCubit());
  }
}
