import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Sign in',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _email,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.5),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _pass,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.5),
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _email.text,
                          password: _pass.text,
                        );
                      } on FirebaseAuthException catch (e) {
                        return showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content: Text(e.message!),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                      } catch (e) {
                        return showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text(
                                      'There was an error wile trying to sign in.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                      }
                    },
                    child: const Text('Sign in'),
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: _email.text,
                          password: _pass.text,
                        );
                      } on FirebaseAuthException catch (e) {
                        return showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content: Text(e.message!),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                      } catch (e) {
                        return showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text(
                                      'There was an error wile trying to sign in.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                      }
                    },
                    child: const Text('Create an account'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
