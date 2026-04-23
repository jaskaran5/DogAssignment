import 'package:assignment_dog/presentation/blocs/auth/auth_bloc.dart';
import 'package:assignment_dog/presentation/blocs/dog_breeds/dog_breeds_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppWrapper extends StatelessWidget {
  final Widget child;

  const AppWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
        BlocProvider<DogBreedsBloc>(create: (_) => DogBreedsBloc()),
      ],
      child: child,
    );
  }
}
