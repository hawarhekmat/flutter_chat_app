import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'screens/home.dart';
import 'screens/sign_in.dart';

class AuthState extends StatefulWidget {
  const AuthState({super.key});

  @override
  State<AuthState> createState() => _AuthStateState();
}

class _AuthStateState extends State<AuthState> {
  final authChange = FirebaseAuth.instance.userChanges();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (snapshot.hasData) {
          return const Home();
        } else {
          return const SignIn();
        }
      },
    );
  }
}
