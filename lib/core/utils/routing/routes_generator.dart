import 'package:assignment_dog/config/helper.dart';
import 'package:assignment_dog/presentation/pages/dog_breeds_screen.dart';
import 'package:assignment_dog/presentation/pages/home_screen.dart';
import 'package:assignment_dog/presentation/pages/login_screen.dart';
import 'package:assignment_dog/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    settings.arguments;
    printLog('Current Screen: ${settings.name}');
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.dogBreeds:
        return MaterialPageRoute(builder: (_) => const DogBreedsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const ErrorRoute());
    }
  }
}

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: const Center(
        child: Text('No Such screen found in route generator'),
      ),
    );
  }
}
