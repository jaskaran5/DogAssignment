import 'package:assignment_dog/config/helper.dart';
import 'package:assignment_dog/core/helpers/all_getter.dart';
import 'package:assignment_dog/core/helpers/app_injector.dart';
import 'package:assignment_dog/core/helpers/app_wrapper.dart';
import 'package:assignment_dog/core/utils/routing/routes.dart';
import 'package:assignment_dog/core/utils/routing/routes_generator.dart';
import 'package:flutter/material.dart';

import 'config/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInjector.init(appRunner: () => runApp(const DogBreedsApp()));
}

class DogBreedsApp extends StatelessWidget {
  const DogBreedsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      child: GestureDetector(
        onTap: () {
          unFocus();
        },
        child: MaterialApp(
          title: 'Dog Breeds',
          debugShowCheckedModeBanner: false,
          navigatorKey: Getters.navKey,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          initialRoute: Routes.splash,
          onGenerateRoute: RouteGenerator.generateRoute,
          onGenerateInitialRoutes: (String initialRouteName) {
            return [
              RouteGenerator.generateRoute(
                const RouteSettings(name: Routes.splash),
              ),
            ];
          },
        ),
      ),
    );
  }
}
