import 'package:anywhere/core/network/network_service.dart';
import 'package:anywhere/screens/Home/cubit/home_cubit.dart';
import 'package:anywhere/screens/Home/service/home_service.dart';
import 'package:get_it/get_it.dart';

void registerCubit(GetIt serviceLocator) {
  serviceLocator.registerSingleton(
    HomeCubit(
      HomeService(
        networkService: NetworkService()
      ),
    ),
  );
}
