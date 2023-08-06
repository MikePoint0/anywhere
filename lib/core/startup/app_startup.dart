import 'package:anywhere/core/navigation/navigation_service.dart';
import 'package:anywhere/core/network/network_info.dart';
import 'package:anywhere/core/startup/error_config.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'environment.dart';
import 'register_cubit.dart';

final GetIt serviceLocator = GetIt.I;

Future initLocator() async {
  await setupConfig();
  // do not put anything before setupconfig
  // await checkForUpdate();

  errorLogConfig();

  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());

  serviceLocator.registerSingleton<NavigationService>(NavigationService());
  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(serviceLocator()),
  );

  registerCubit(serviceLocator);

  // This should be called last
  serviceLocator.pushNewScope(scopeName: 'app_start');
}

clearUserData() async {
  // userDetails.value = null;
  // if (serviceLocator.isRegistered<UserModel>()) {
  //   serviceLocator.unregister<UserModel>();
  // }
  await serviceLocator.resetScope();
}
