import 'package:assignment_dog/config/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        print('state is :$state');
        if (state.status == AuthStatus.error) {
          showSnackBar(message: state.errorMessage);
        }
      },
      builder: (context, state) {
        final isLoading = state.status == AuthStatus.loading;
        final showPass = state.isPasswordVisible;
        final bloc = context.read<AuthBloc>();
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1B5E20),
                  Color(0xFF2E7D32),
                  Color(0xFF4CAF50),
                ],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    yHeight(20),

                    /// 🐾 Logo
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                      ),
                      child: const Center(
                        child: Text('🐾', style: TextStyle(fontSize: 42)),
                      ),
                    ),

                    yHeight(16),

                    const Text(
                      'DogBreeds',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),

                    yHeight(6),

                    Text(
                      'Sign in or create an account',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 14,
                      ),
                    ),

                    yHeight(40),

                    /// 🔲 Card Section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          yHeight(6),

                          const Text(
                            'Enter your credentials to continue.\nNew users are registered automatically.',
                          ),

                          yHeight(24),

                          /// Username
                          TextFormField(
                            controller: bloc.userName,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person_outline),
                              hintText: 'Enter username',
                            ),
                          ),

                          yHeight(16),

                          /// Password
                          TextFormField(
                            controller: bloc.password,
                            obscureText: !showPass,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outline),
                              hintText: 'Enter password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  showPass
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  bloc.add(ToggleShowPassEvent());
                                },
                              ),
                            ),
                          ),

                          yHeight(16),

                          /// Info Box
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFFA5D6A7),
                              ),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 16,
                                  color: Color(0xFF2E7D32),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'New user? You\'ll be registered automatically.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF2E7D32),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          yHeight(24),

                          /// Button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      bloc.add(LoginOrRegisterEvent());
                                    },
                              child: isLoading
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text('Continue'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
