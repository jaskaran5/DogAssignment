import 'package:assignment_dog/config/helper.dart';
import 'package:assignment_dog/core/helpers/all_getter.dart';
import 'package:assignment_dog/core/utils/routing/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (context.mounted) {
        if (Getters.getLocalStorage.isLoggedIn()) {
          offAllNamed(context, Routes.home);
        } else {
          offAllNamed(context, Routes.login);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF388E3C)],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: .center,
              spacing: 8,
              children: [
                const Text(
                  'DogBreeds',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  'Discover every breed',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .75),
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
