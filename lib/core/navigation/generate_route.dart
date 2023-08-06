import 'package:anywhere/core/navigation/keys.dart';
import 'package:anywhere/screens/Home/home.dart';
import 'package:anywhere/screens/details/details.dart';
import 'package:anywhere/screens/splash/root.dart';
import 'package:flutter/material.dart';

Route generateRoute(RouteSettings settings) {
  String routeName = settings.name ?? '';

  switch (routeName) {
    case RouteKeys.splash:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const SplashScreen());
    case RouteKeys.home:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => HomeScreen(),
      );
    case RouteKeys.details:
      Map args = settings.arguments as Map;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => DetailsScreen(relatedTopics: args["relatedTopic"]),
      );

    default:
      return MaterialPageRoute(
          settings: settings,
          builder: (_) => _ErrorScreen(routeName: routeName));
  }
}

class _ErrorScreen extends StatelessWidget {
  final String routeName;
  const _ErrorScreen({Key? key, required this.routeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Route '$routeName' does not exist"),
      ),
    );
  }
}
